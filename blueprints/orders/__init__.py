from flask import Blueprint, render_template, request, current_app, jsonify, redirect, url_for, session, flash
from flask_login import login_required, current_user
from alchemyClasses import db
from alchemyClasses.Producto import Producto
from alchemyClasses.Usuario import Usuario
from alchemyClasses.Pago import Pago
from alchemyClasses.Pedido import Pedido
from alchemyClasses.Reparacion import Reparacion
from alchemyClasses.producto_pedido import producto_pedido
from alchemyClasses.CheckoutPendiente import CheckoutPendiente
from alchemyClasses.Factura import Factura
from decimal import Decimal
import mercadopago
import json
from datetime import datetime, timezone, timedelta
from email_validator import validate_email, EmailNotValidError
from decimal import Decimal
import math
import resend
import threading
import os
import hmac
import hashlib

orders_bp = Blueprint("orders", __name__, url_prefix="/orders")

def enviar_correo(email, nombre_cliente, id_cliente, id_pedido, estado_pedido, total, fecha_pedido):
    if not email or not nombre_cliente:
        return

    resend.api_key = os.getenv("RESEND_API_KEY")
    if not resend.api_key:
        current_app.logger.error("No se encontró la clave de API de Resend.")
        return

    resend.Emails.send({
            "from": f"Gases, Equipos y Soldaduras <{os.getenv('MAIL_FROM')}>",
            "to": [email],
            "subject": f"Confirmación de pedido #{id_pedido}",
            "html": f"""
            <p>Hola {nombre_cliente},</p>
    
            <p>Gracias por tu compra. Tu pedido con ID {id_pedido} ha sido recibido y está en proceso.</p>
            <p>
                Detalles del pedido:
            </p>
            <ul>
                <li>ID del pedido: {id_pedido}</li>
                <li>Estado del pedido: {estado_pedido}</li>
                <li>Total: ${total:.2f}</li>
                <li>Fecha del pedido: {fecha_pedido.strftime('%Y-%m-%d %H:%M:%S')}</li>
            </ul>
    
            <p>Gracias por tu compra.</p>
    
            <p>
                Saludos,<br>
                Gases, Equipos y Soldaduras
            </p>
            """
        })

def enviar_correo_admin(nombre_cliente, id_cliente, total, fecha, id_pedido):
    resend.api_key=os.getenv("RESEND_API_KEY")
    if not resend.api_key:
            current_app.logger.error("No se encontró la clave de API de Resend.")
            return
    resend.Emails.send({
        "from": f"Receptor de pedidos <{os.getenv('MAIL_FROM')}>",
                    "to": os.getenv('MAIL_ADMIN'),
                    "subject": f"Pedido recibido! #{id_pedido}",
                    "html": f"""
                    <p> Hola admin <p>
                    <p>El cliente {nombre_cliente}, con id: {id_cliente}</p>
                    <p> Realizo el pedido {id_pedido}.<p>
                    <p> El día {fecha}, por un total de: {total}.
                    <p> Favor de checarlo lo antes posible."""
            
    })
def enviar_correo_factura(nombre_cliente, id_pedido):
    resend.api_key=os.getenv("RESEND_API_KEY")
    if not resend.api_key:
            current_app.logger.error("No se encontró la clave de API de Resend.")
            return
    resend.Emails.send({
        "from": f"Receptor de pedidos <{os.getenv('MAIL_FROM')}>",
                    "to": os.getenv('MAIL_ADMIN'),
                    "subject": f"Solicitud de factura! #{id_pedido}",
                    "html": f"""
                    <p> Hola admin <p>
                    <p>El cliente {nombre_cliente}, con id: {id_pedido}</p>
                    <p> Solicito la factura del pedido {id_pedido}.<p>
                    <p> Favor de checarlo lo antes posible."""
            
    })
def crear_pedido_desde_checkout(
    checkout,
    metodo_pago,
    id_transaccion=None
):
    carrito = json.loads(checkout.carrito_json)

    usuario = db.session.get(
        Usuario,
        checkout.id_usuario
    )

    if not usuario:
        raise ValueError("Usuario no encontrado.")

    if checkout.estado == "pagado":
        return None

    puntos_usados = int(checkout.total - checkout.monto)

    if usuario.puntos < puntos_usados:
        raise ValueError(
            "El usuario ya no tiene suficientes puntos."
        )

    # Como se usaron puntos, no se generan nuevos puntos.
    if puntos_usados > 0:
        puntos_generados = 0
    else:
        puntos_generados = math.floor(checkout.total * Decimal("0.020"))

    nuevo_pedido = Pedido(
        id_usuario=checkout.id_usuario,
        direccion_envio=checkout.direccion_envio,
        total=checkout.total,
        estado_pedido="En preparación",
        puntos_usados=puntos_usados,
        puntos_generado=puntos_generados
    )

    usuario.puntos += puntos_generados

    db.session.add(nuevo_pedido)
    db.session.flush()

    for id_producto, item in carrito.items():

        detalle = producto_pedido(
            id_pedido=nuevo_pedido.id_pedido,
            id_producto=int(id_producto),
            cantidad=int(item["cantidad"]),
            precio_unitario=Decimal(str(item["precio"]))
        )

        db.session.add(detalle)

    usuario.puntos -= puntos_usados

    pago = Pago(
        id_pedido=nuevo_pedido.id_pedido,
        metodo_pago=metodo_pago,
        estado_pago="Aprobado",
        id_transaccion=id_transaccion,
        fecha_pago=datetime.now(timezone.utc),
        monto=checkout.monto
    )

    db.session.add(pago)

    checkout.estado = "pagado"

    return nuevo_pedido


@orders_bp.route("/")
@login_required
def index():
    pedidos = (
        Pedido.query
        .filter_by(id_usuario=current_user.id_usuario)
        .order_by(Pedido.fecha_pedido.desc())
        .all()
    )

    return render_template("orders/index.html", 
    pedidos=pedidos,
    now = datetime.now(),
    timedelta = timedelta)

@orders_bp.route("/reparaciones")
@login_required
def reparaciones():
    reparaciones = (
        db.session.query(
            Reparacion
        )
        .filter(Reparacion.id_usuario == current_user.id_usuario)
        .order_by(Reparacion.fecha_reparacion.desc())
        .all()
    )

    return render_template(
        "orders/reparaciones.html",
        reparaciones=reparaciones
    )


@orders_bp.route("/<int:id_pedido>")
@login_required
def detalle_pedido(id_pedido):
    pedido = Pedido.query.get_or_404(id_pedido)

    if pedido.id_usuario != current_user.id_usuario:
        flash("No tienes permiso para ver este pedido.", "danger")
        return redirect(url_for("orders.index"))

    detalles = (
        db.session.query(
            Producto,
            producto_pedido.cantidad,
            producto_pedido.precio_unitario
        )
        .join(
            producto_pedido,
            Producto.id_producto == producto_pedido.id_producto
        )
        .filter(producto_pedido.id_pedido == pedido.id_pedido)
        .all()
    )
    pago = Pago.query.filter_by(id_pedido=pedido.id_pedido).first()

    return render_template(
        "orders/detalle.html",
        pedido=pedido,
        detalles=detalles,
        pago=pago
    )
@orders_bp.route("/preparar-checkout", methods=["POST"])
@login_required
def preparar_checkout():

    carrito = session.get("carrito", {})

    if not carrito:
        flash("Tu carrito está vacío.", "warning")
        return redirect(url_for("products.carrito"))

    session["usar_puntos"] = (
        request.form.get("usar_puntos") == "1"
    )

    return redirect(url_for("orders.ubicacion"))

@orders_bp.route("/ubicacion", methods=["GET"])
@login_required
def ubicacion():
    carrito = session.get("carrito", {})
    puntos = False
    monto = 1
    if not carrito:
        flash("Tu carrito está vacío.", "warning")
        return redirect(url_for("products.carrito"))
    usar_puntos = session.get("usar_puntos", False)
    puntos_disp = current_user.puntos
    total = sum(
        float(item["precio"]) * int(item["cantidad"])
        for item in carrito.values()
    )
    if usar_puntos and puntos_disp > 0:
        monto = total - puntos_disp
    if monto <= 0:
        puntos = True

    return render_template("orders/ubicacion.html", puntos=puntos)


@orders_bp.route("/validar-ubicacion", methods=["POST"])
@login_required
def validar_ubicacion():

    estados_permitidos = [
        "Ciudad de México",
        "Estado de México",
        "Morelos"
    ]

    estado = request.form.get("estado")
    colonia = request.form.get("colonia")
    calle = request.form.get("calle")
    numero = request.form.get("numero")
    cp = request.form.get("cp")

    if estado not in estados_permitidos:
        flash("No contamos con cobertura en ese estado.", "danger")
        return redirect(url_for("orders.ubicacion"))

    carrito = session.get("carrito", {})

    if not carrito:
        flash("Tu carrito está vacío.", "warning")
        return redirect(url_for("products.carrito"))

    direccion_envio = (
        f"Calle {calle} #{numero}, "
        f"Col. {colonia}, "
        f"C.P. {cp}, "
        f"{estado}"
    )

    total = sum(
        float(item["precio"]) * int(item["cantidad"])
        for item in carrito.values()
    )

    usar_puntos = session.get("usar_puntos", False)
    puntos_disp = current_user.puntos or 0
    puntos_uso = 0
    monto = total
    if usar_puntos and puntos_disp > 0:
        puntos_uso = min(
            puntos_disp, int(total)
        )
        monto = total - puntos_uso

    checkout = CheckoutPendiente(
        id_usuario=current_user.id_usuario,
        direccion_envio=direccion_envio,
        carrito_json=json.dumps(carrito),
        total=total,
        monto = monto,
        estado="pendiente"
    )

    db.session.add(checkout)
    db.session.flush()

    items = [{
        "id": f"checkout-{checkout.id_checkout}",
        "title": "Pedido GASEMEX",
        "description": (
            f"Total ${float(total):.2f}, "
            f"puntos utilizados: {puntos_uso}"
         ),
         "quantity": 1,
        "unit_price": float(monto),
        "currency_id": "MXN"
        }]

    base_url = current_app.config["BASE_URL"]

    preference_data = {
        "items": items,
        "external_reference": str(checkout.id_checkout),
        "back_urls": {
            "success": f"{base_url}{url_for('orders.pago_exitoso')}",
            "failure": f"{base_url}{url_for('orders.pago_fallido')}",
            "pending": f"{base_url}{url_for('orders.pago_pendiente')}",
        },
        "auto_return": "approved",
        "notification_url": f"{base_url}{url_for('orders.webhook_mp')}",
    }
    if monto <= 0:

        try:
            pedido = crear_pedido_desde_checkout(
            checkout=checkout,
            metodo_pago="Puntos"
            )
            db.session.commit()

        except ValueError as error:
            db.session.rollback()
            flash(str(error), "danger")
            return redirect(url_for("products.carrito"))

        session.pop("carrito", None)
        session.pop("usar_puntos", None)

        email = current_user.email
        id_cliente = current_user.id_usuario
        nombre_cliente = current_user.nombre_usuario
        estado_pedido = pedido.estado_pedido
        total = pedido.total
        fecha_pedido = pedido.fecha_pedido
        id_pedido = pedido.id_pedido

        flash(
            "Pedido pagado completamente con puntos. Un correo de confirmación ha sido enviado.",
            "success"
        )
        app = current_app._get_current_object()
        def enviar_en_segundo_plano():

            with app.app_context():

                try:
                    enviar_correo(
                    email,
                    nombre_cliente,
                    id_cliente,
                    id_pedido,
                    estado_pedido,
                    total,
                    fecha_pedido
                    )
                except Exception:
                    app.logger.exception(
                    "Error enviando correo al cliente"
                    )

                try:
                    enviar_correo_admin(
                    nombre_cliente,
                    id_cliente,
                    total,
                    fecha_pedido,
                    id_pedido
                )
                except Exception:
                    app.logger.exception(
                    "Error enviando correo al administrador"
                )
                    
        threading.Thread(target=enviar_en_segundo_plano, daemon = True).start()
        return redirect(
            url_for(
                "orders.detalle_pedido",
                id_pedido=pedido.id_pedido
            )
        )
    sdk = mercadopago.SDK(current_app.config["MP_ACCESS_TOKEN"])

    preference_response = sdk.preference().create(preference_data)

    print("Preference created:", preference_response)

    if preference_response["status"] not in [200, 201]:
        db.session.rollback()
        flash("No se pudo crear el pago en Mercado Pago.", "danger")
        return redirect(url_for("products.carrito"))

    preference = preference_response["response"]

    checkout.id_preferencia = preference["id"]

    db.session.commit()

    checkout_url = (
        preference.get("init_point")
    )

    if not checkout_url:
        flash("Mercado Pago no devolvió una URL de pago.", "danger")
        return redirect(url_for("products.carrito"))

    return redirect(checkout_url)


@orders_bp.route("/pago/exitoso")
@login_required
def pago_exitoso():
    pedido=Pedido.query.filter_by(
    id_usuario=current_user.id_usuario
    ).order_by(Pedido.fecha_pedido.desc()).first()
    cliente=current_user
    email = cliente.email
    nombre_cliente = cliente.nombre_usuario
    id_cliente = cliente.id_usuario
    estado_pedido = pedido.estado_pedido
    total = pedido.total
    fecha_pedido = pedido.fecha_pedido
    id_pedido = pedido.id_pedido

    session.pop("carrito", None)

    flash(
        "Pago recibido. Estamos confirmando tu pedido. Un correo de confirmación será enviado.",
        "success"
    )
    app = current_app._get_current_object()
    def enviar_en_segundo_plano():
    
                with app.app_context():
    
                    try:
                        enviar_correo(
                        email,
                        nombre_cliente,
                        id_cliente,
                        id_pedido,
                        estado_pedido,
                        total,
                        fecha_pedido
                        )
                    except Exception:
                        app.logger.exception(
                        "Error enviando correo al cliente"
                        )
    
                    try:
                        enviar_correo_admin(
                        nombre_cliente,
                        id_cliente,
                        total,
                        fecha_pedido,
                        id_pedido
                    )
                    except Exception:
                        app.logger.exception(
                        "Error enviando correo al administrador"
                    )
                        
    threading.Thread(target=enviar_en_segundo_plano, daemon = True).start()

    return redirect(url_for("orders.index"))


@orders_bp.route("/pago/pendiente")
@login_required
def pago_pendiente():
    flash(
        "Tu pago está pendiente de confirmación.",
        "warning"
    )
    return redirect(url_for("orders.index"))


@orders_bp.route("/pago/fallido")
@login_required
def pago_fallido():
    flash(
        "No fue posible procesar el pago. Puedes intentarlo nuevamente.",
        "danger"
    )
    return redirect(url_for("products.carrito"))


@orders_bp.route("/webhook/mercadopago", methods=["POST"])
def webhook_mp():

    secret = current_app.config["MP_WEBHOOK_SECRET"]

    x_signature = request.headers.get("x-signature")
    x_request_id = request.headers.get("x-request-id")

    data = request.get_json(silent=True) or {}

    data_id = request.args.get("data.id")

    if not x_signature or not x_request_id or not data_id:
        return jsonify({
            "status": "invalid_signature_data"
        }), 401

    # Extraer ts y v1 de x-signature
    parts = {}

    for item in x_signature.split(","):
        key, value = item.strip().split("=", 1)
        parts[key] = value

    ts = parts.get("ts")
    v1 = parts.get("v1")

    if not ts or not v1:
        return jsonify({
            "status": "invalid_signature"
        }), 401

    # Manifest requerido por Mercado Pago
    manifest = (
        f"id:{data_id};"
        f"request-id:{x_request_id};"
        f"ts:{ts};"
    )

    generated_signature = hmac.new(
        secret.encode(),
        manifest.encode(),
        hashlib.sha256
    ).hexdigest()

    if not hmac.compare_digest(generated_signature, v1):
        current_app.logger.warning(
            "Firma inválida de Mercado Pago"
        )

        return jsonify({
            "status": "invalid_signature"
        }), 401


    tipo = data.get("type") or data.get("topic")

    if tipo != "payment":
        return jsonify({"status": "ignored"}), 200

    payment_id = None

    if data.get("data"):
        payment_id = data["data"].get("id")

    if not payment_id:
        payment_id = data.get("id")

    if not payment_id:
        return jsonify({"status": "no_payment_id"}), 200

    sdk = mercadopago.SDK(
        current_app.config["MP_ACCESS_TOKEN"]
    )

    payment_response = sdk.payment().get(payment_id)

    if payment_response.get("status") != 200:
        return jsonify({
            "status": "payment_not_found"
        }), 200

    payment = payment_response.get("response", {})
    monto_pagado = payment.get("transaction_amount")

    if monto_pagado is None:
        current_app.logger.warning(
            "Mercado Pago no proporcionó transaction_amount"
        )
        return jsonify({"status": "no_transaction_amount"}), 200

    id_checkout = payment.get("external_reference")

    if not id_checkout:
        return jsonify({
            "status": "no_external_reference"
        }), 200

    try:
        id_checkout = int(id_checkout)
    except (TypeError, ValueError):
        return jsonify({
            "status": "invalid_external_reference"
        }), 200

    checkout = (
        db.session.query(CheckoutPendiente)
        .filter_by(id_checkout=id_checkout)
        .with_for_update()
        .first()
        )
    monto_esperado = round(float(checkout.monto), 2)
    monto_recibido = round(float(monto_pagado), 2)

    if monto_recibido != monto_esperado:
        current_app.logger.warning(
            f"Mismatch de monto en checkout {checkout.id_checkout}: "
            f"esperado={monto_esperado}, recibido={monto_recibido}"
        )

        return jsonify({
            "status": "amount_mismatch"
        }), 200

    if not checkout:
        return jsonify({
            "status": "checkout_not_found"
        }), 200

    usuario = db.session.get(
        Usuario,
        checkout.id_usuario
    )

    if not usuario:
        return jsonify({
            "status": "error",
            "message": "Usuario no encontrado"
        }), 404

    status_mp = payment.get("status")

    if status_mp == "approved":

        # Mercado Pago puede enviar varias veces el mismo webhook.
        if checkout.estado == "pagado":
            return jsonify({
                "status": "already_processed"
            }), 200

        puntos_usados = int(
            checkout.total - checkout.monto or 0
        )

        metodo_mp = (
            payment.get("payment_method_id")
            or "Mercado Pago"
        )

        if puntos_usados > 0:
            metodo_pago = f"Puntos + {metodo_mp}"
        else:
            metodo_pago = metodo_mp

        try:
            nuevo_pedido = crear_pedido_desde_checkout(
                checkout=checkout,
                metodo_pago=metodo_pago,
                id_transaccion=str(payment.get("id"))
            )

            db.session.commit()

        except ValueError as error:
            db.session.rollback()

            return jsonify({
                "status": "points_error",
                "message": str(error)
            }), 409

        except Exception:
            db.session.rollback()
            current_app.logger.exception(
                "Error al procesar webhook de Mercado Pago"
            )

            return jsonify({
                "status": "internal_error"
            }), 500

        return jsonify({
            "status": "processed",
            "id_pedido": nuevo_pedido.id_pedido
        }), 200

    if status_mp in ["pending", "in_process"]:
        checkout.estado = "pendiente"

    elif status_mp in ["rejected", "cancelled"]:
        checkout.estado = "cancelado"

    elif status_mp in ["refunded", "charged_back"]:
        checkout.estado = "cancelado"

    db.session.commit()

    return jsonify({"status": "ok"}), 200

@orders_bp.route("/factura/<int:id_pedido>")
@login_required
def solicitar_factura(id_pedido):

    pedido = Pedido.query.get_or_404(id_pedido)
    limite = pedido.pago.fecha_pago + timedelta(days=1)
    if datetime.now() > limite:
        flash("El tiempo para solicitar la factura ha expirado.", "danger")
        return redirect(url_for("orders.index"))

    if pedido.id_usuario != current_user.id_usuario:
        flash("No tienes permiso.", "danger")
        return redirect(url_for("orders.index"))

    if not pedido.pago or pedido.pago.estado_pago != "Aprobado":
        flash("Solo es posible facturar pedidos pagados.", "warning")
        return redirect(url_for("orders.index"))
    

    return render_template(
        "orders/factura.html",
        pedido=pedido
    )

@orders_bp.route("/factura/<int:id_pedido>", methods=["POST"])
@login_required
def guardar_factura(id_pedido):

    pedido = Pedido.query.get_or_404(id_pedido)
    usuario = current_user
    nombre_usuario = usuario.nombre_usuario
    id_pedido = pedido.id_pedido

    if pedido.id_usuario != current_user.id_usuario:
        return redirect(url_for("orders.index"))

    rfc = request.form["rfc"].upper()
    razon_social = request.form["razon_social"]
    codigo_postal = request.form["codigo_postal"]
    regimen = request.form["regimen"]
    uso_cfdi = request.form["uso_cfdi"]
    correo = request.form["correo"]

    if rfc == "" or razon_social == "" or codigo_postal == "" or regimen == "" or uso_cfdi == "" or correo == "":
        flash("Todos los campos son obligatorios.", "danger")
        return redirect(url_for("orders.solicitar_factura", id_pedido=id_pedido))
    if len(codigo_postal) != 5 or not codigo_postal.isdigit():
        flash("El código postal debe tener 5 dígitos.", "danger")
        return redirect(url_for("orders.solicitar_factura", id_pedido=id_pedido))
    if len(rfc) < 12 or len(rfc) > 13:
        flash("El RFC debe tener entre 12 y 13 caracteres.", "danger")
        return redirect(url_for("orders.solicitar_factura", id_pedido=id_pedido))
    rfc = rfc.upper()
    try :
        validate_email(correo)
    except EmailNotValidError:
        flash("Correo electrónico inválido.", "danger")
        return redirect(url_for("orders.solicitar_factura", id_pedido=id_pedido))

    factura = Factura(
        rfc=rfc,
        razon_social=razon_social,
        codigo_postal=codigo_postal,
        regimen_fiscal=regimen,
        uso_cfdi=uso_cfdi,
        correo=correo,
        id_pedido=id_pedido
    )
    db.session.add(factura)
    db.session.commit()


    flash(
        "Solicitud de factura enviada correctamente. Revise su correo a lo largo del día",
        "success"
    )
    pedido.factura = True
    db.session.commit()
    app = current_app._get_current_object()
    def enviar_correo_factura():
        with app.app_context():
            enviar_correo_factura(
                nombre_usuario,
                id_pedido
            )
    threading.Thread(target=enviar_correo_factura, daemon = True).start()

    return redirect(url_for("orders.index"))