from flask import Blueprint, render_template, redirect, url_for, request, flash, current_app
from flask_login import login_required
from alchemyClasses import db
from alchemyClasses.Usuario import Usuario
from alchemyClasses.Pedido import Pedido
from alchemyClasses.producto_pedido import producto_pedido
from alchemyClasses.Reparacion import Reparacion
from alchemyClasses.Factura import Factura
from datetime import datetime, timedelta
from blueprints.role_views import admin_required
from flask_mail import Message
from extensions import mail
import threading
import os
import resend


admin_bp = Blueprint("admin", __name__, url_prefix="/admin")

@admin_bp.route("/")
@login_required
@admin_required
def index():
    pedidos = Pedido.query.count()
    clientes = Usuario.query.filter_by(rol="cliente").count()
    reparaciones = Reparacion.query.count()
    facturas = Factura.query.count()
    hola = pedidos + clientes + reparaciones + facturas
    print("-------------------------------", hola)
    return render_template(
        "dashboard/admin.html",
        pedidos=pedidos,
        clientes=clientes,
        reparaciones=reparaciones,
        facturas=facturas
    )

@admin_bp.route("/pedidos")
@login_required
@admin_required
def pedidos():
    pedidos = Pedido.query.order_by(Pedido.fecha_pedido.desc()).all()
    return render_template("admin/pedidos.html", pedidos=pedidos)

@admin_bp.route("/reparaciones")
@login_required
@admin_required
def reparaciones():
    reparaciones = Reparacion.query.order_by(Reparacion.fecha_reparacion.desc()).all()
    return render_template("admin/reparaciones.html", reparaciones=reparaciones)

@admin_bp.route("/clientes")
@login_required
@admin_required
def clientes():
    clientes = Usuario.query.filter_by(rol="cliente").all()
    return render_template("admin/clientes.html", clientes=clientes)

@admin_bp.route("/facturas")
@login_required
@admin_required
def facturas():
    facturas = Factura.query.order_by(Factura.fecha_factura.desc()).all()
    return render_template("admin/facturas.html", facturas=facturas)

@admin_bp.route("/pedido/<int:id_pedido>/detalles")
@login_required
@admin_required
def detalles_pedido(id_pedido):
    pedido = Pedido.query.get_or_404(id_pedido)
    cliente = pedido.usuario
    detalles = producto_pedido.query.filter_by(id_pedido=id_pedido).all()
    return render_template("admin/detalles_pedido.html", pedido=pedido, detalles=detalles, cliente = cliente)


@admin_bp.route("/reparacion/<int:id_reparacion>/estado", methods=["POST"])
@login_required
@admin_required
def cambiar_estado_reparacion(id_reparacion):

    reparacion = Reparacion.query.get_or_404(id_reparacion)

    nuevo_estado = request.form.get("estado_reparacion")

    estados_validos = [
        "Recibido",
        "En revisión",
        "En reparación",
        "Lista para entregar",
        "Entregada",
        "Cancelada"
    ]

    if nuevo_estado not in estados_validos:
        flash("Estado de reparación no válido.", "danger")
        return redirect(url_for("admin.index"))

    reparacion.estado_reparacion = nuevo_estado
    db.session.commit()

    flash("Estado de reparación actualizado.", "success")
    return redirect(url_for("admin.index"))

@admin_bp.route("/pedido/<int:id_pedido>/estado", methods=["POST"])
@login_required
@admin_required
def cambiar_estado(id_pedido):
    pedido = Pedido.query.get_or_404(id_pedido)

    nuevo_estado = request.form.get("estado_pedido")
    cliente = pedido.usuario  # Obtener el cliente asociado al pedido

    estados_validos = [
        "En preparación",
        "En ruta",
        "Entregado"
    ]

    if nuevo_estado not in estados_validos:
        flash("Estado no válido.", "danger")
        return redirect(url_for("admin.index"))

    pedido.estado_pedido = nuevo_estado
    db.session.commit()

    email = cliente.email
    nombre_usuario = cliente.nombre_usuario
    id_pedido = pedido.id_pedido
    estado_pedido = pedido.estado_pedido

    app = current_app._get_current_object()

    def enviar_en_segundo_plano():
        with app.app_context():
            enviar_correo(
                email,
                nombre_usuario,
                id_pedido,
                estado_pedido
            )

    threading.Thread(
        target=enviar_en_segundo_plano,
        daemon=True
    ).start()

    flash("Estado del pedido actualizado.", "success")
    return redirect(url_for("admin.index"))


def enviar_correo(email, nombre_usuario, id_pedido, estado_pedido):
    resend.api_key = os.getenv("RESEND_API_KEY")

    resend.Emails.send({
        "from": "Gases, Equipos y Soldaduras <actualizaciones@gasemex.shop>",
        "to": [email],
        "subject": f"Actualización de tu pedido #{id_pedido}",
        "html": f"""
        <p>Hola {nombre_usuario},</p>

        <p>El estado de tu pedido <strong>#{id_pedido}</strong> ha sido actualizado.</p>

        <p>
            Nuevo estado: <strong>{estado_pedido}</strong>
        </p>

        <p>Gracias por tu compra.</p>

        <p>
            Saludos,<br>
            Gases, Equipos y Soldaduras
        </p>
        """
    })
    

@admin_bp.route("/reparacion/nueva", methods=["GET", "POST"])
@login_required
@admin_required
def agregar_reparacion():
    clientes = Usuario.query.filter_by(rol="cliente").all()
    if request.method == "POST":
        id_cliente = request.form.get("id_cliente")
        equipo = request.form.get("equipo")
        descripcion = request.form.get("descripcion")

        reapracion = Reparacion(
            id_usuario=id_cliente,
            nombre_reparacion=equipo,
            descripcion_reparacion=descripcion,
            estado_reparacion= 'Recibido',
            fecha_reparacion=datetime.now()
        )
        db.session.add(reapracion)
        db.session.commit()

        flash("Reparación registrada correctamente.", "success")
        return redirect(url_for("admin.index"))

    return render_template("admin/reparacion.html", clientes = clientes)


