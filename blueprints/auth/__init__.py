from flask import Blueprint, render_template, request, redirect, url_for, flash
import re
from alchemyClasses.Usuario import Usuario
from alchemyClasses.password_reset_tokens import PasswordResetToken
from alchemyClasses import db
from email_validator import validate_email, EmailNotValidError
from flask_login import login_user, logout_user, login_required
from blueprints.role_views import anonymous_required
from extensions import limiter
import hashlib
import secrets
from datetime import datetime, timedelta
import os
import resend



auth_bp = Blueprint("auth", __name__, url_prefix="/auth")


@auth_bp.route('/register', methods=['GET', 'POST'])
@anonymous_required
@limiter.limit("5 per minute")  # Limitar a 5 solicitudes por minuto
def register():

    if request.method == 'POST':

        nombre_usuario = request.form['nombre']
        email = request.form['email']
        telefono = request.form['telefono']
        contrasena_usuario = request.form['password']
        confirm_password = request.form['confirm_password']

        if len(nombre_usuario) < 3:
            flash("El nombre es demasiado corto", "danger")
            return redirect(url_for('auth.register'))
        
        if contrasena_usuario != confirm_password:
            flash("Las contraseñas no coinciden", "danger")
            return redirect(url_for('auth.register'))
        
        if len(contrasena_usuario) < 8:
            flash("La contraseña debe tener al menos 8 caracteres", "danger")
            return redirect(url_for('auth.register'))

        if not re.match(r'^\d{10}$', telefono):
            flash("El teléfono debe tener 10 dígitos", "danger" )
            return redirect(url_for('auth.register'))

        try:
            validate_email(email)
        except EmailNotValidError:
            flash("Correo electrónico inválido", "danger")
            return redirect(url_for('auth.register'))

        nombre_existente = Usuario.query.filter_by(nombre_usuario=nombre_usuario).first()
        usuario_existente = Usuario.query.filter_by(email=email).first()

        if nombre_existente:
            flash("Ya existe un usuario con ese nombre", "danger")
            return redirect(url_for('auth.register'))

        if usuario_existente:
            flash("Ya existe una cuenta con ese correo", "danger")
            return redirect(url_for('auth.register'))
        if not request.form.get("privacidad"):
            flash(
                "Debes consultar y aceptar el aviso de privacidad.",
                "warning"
            )
            return redirect(url_for("auth.register"))

        nuevo_usuario = Usuario(
            nombre_usuario=nombre_usuario,
            email=email,
            telefono=telefono,
            contrasena_usuario=contrasena_usuario
        )
        nuevo_usuario.set_password(contrasena_usuario)

        db.session.add(nuevo_usuario)
        db.session.commit()

        flash('Cuenta creada correctamente', 'success')
        print("exito")
        login_user(nuevo_usuario)
        return redirect(url_for('role_views.index'))

    return render_template('auth/register.html')

@auth_bp.route('/login', methods=['GET', 'POST'])
@anonymous_required
@limiter.limit("5 per minute")  # Limitar a 5 solicitudes por minuto
def login():
    if request.method == 'POST':
        email = request.form['email']
        contrasena_usuario = request.form['password']

        usuario = Usuario.query.filter_by(email=email).first()
        if not usuario:
            flash('Correo no encontrado', 'danger')
            return redirect(url_for('auth.login'))

        if usuario and usuario.check_password(contrasena_usuario):
            login_user(usuario)
            flash('Has iniciado sesión correctamente', 'success')
            return redirect(url_for('role_views.index'))
        else:
            flash('Correo o contraseña incorrectos', 'danger')
            return redirect(url_for('auth.login'))

    return render_template('auth/login.html')

@auth_bp.route("/recuperar-password", methods=["GET", "POST"])
@anonymous_required
@limiter.limit("5 per minute") 
def recuperar_password():
    if request.method == "POST":

        email = request.form.get("email", "").strip().lower()

        # Buscamos el usuario
        usuario = Usuario.query.filter_by(email=email).first()

        if usuario:

        
            token = secrets.token_urlsafe(32)
            token_hash = hashlib.sha256(
                token.encode()
            ).hexdigest()

            expires_at = datetime.now() + timedelta(hours=1)

            reset_token = PasswordResetToken(
                id_usuario=usuario.id_usuario,
                token_hash=token_hash,
                expires_at=expires_at
            )

            db.session.add(reset_token)
            db.session.commit()

            reset_url = url_for(
                "auth.restablecer_password",
                token=token,
                _external=True
            )
            enviar_correo_recuperacion(
                usuario.email,
                usuario.nombre_usuario,
                reset_url
            )

            flash(
                "Si el correo está registrado, recibirás un enlace para restablecer tu contraseña.",
                "success"
             )

        return redirect(url_for("auth.login"))

    return render_template("auth/recuperar_pass.html")



@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Has cerrado sesión', 'success')
    return redirect(url_for('home.inicio'))


def enviar_correo_recuperacion(email, nombre_usuario, reset_url):

    resend.api_key = os.getenv("RESEND_API_KEY")

    resend.Emails.send({
    "from": f"Gases, Equipos y Soldaduras <{os.getenv('RESEND_FROM_EMAIL')}>",
    "to": [email],
    "subject": "Recuperación de contraseña | GASEMEX",
    "html": f"""
    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto;">

        <h2 style="color: #dc3545;">
            Recuperación de contraseña
        </h2>

        <p>
            Hola <strong>{nombre_usuario}</strong>,
        </p>

        <p>
            Recibimos una solicitud para restablecer la contraseña
            de tu cuenta de GASEMEX.
        </p>

        <p>
            Haz clic en el siguiente botón para crear una nueva contraseña:
        </p>

        <div style="text-align: center; margin: 30px 0;">

            <a href="{reset_url}"
               style="
                   background-color: #dc3545;
                   color: white;
                   padding: 12px 24px;
                   text-decoration: none;
                   border-radius: 6px;
                   display: inline-block;
                   font-weight: bold;
               ">
                Restablecer contraseña
            </a>

        </div>

        <p>
            Este enlace será válido durante <strong>1 hora</strong>.
        </p>

        <p>
            Si tú no solicitaste restablecer tu contraseña,
            puedes ignorar este correo.
        </p>

        <hr>

        <p style="color: #777; font-size: 13px;">
            GASEMEX — Gases, Equipos y Soldaduras
        </p>

    </div>
    """
})

@auth_bp.route("/restablecer-password/<token>", methods=["GET", "POST"])
def restablecer_password(token):
    token_hash = hashlib.sha256(
        token.encode()
    ).hexdigest()
    reset_token = PasswordResetToken.query.filter_by(
        token_hash=token_hash,
        used=False
    ).first()

    if not reset_token:

        flash(
            "El enlace de recuperación no es válido.",
            "danger"
        )

        return redirect(url_for("auth.login"))

    if reset_token.expires_at < datetime.now():

        flash(
            "El enlace de recuperación ha expirado. Solicita uno nuevo.",
            "danger"
        )

        return redirect(url_for("auth.recuperar_password"))

    if request.method == "POST":

        password = request.form.get("password", "")
        password_confirm = request.form.get("password_confirm", "")

        if password != password_confirm:

            flash(
                "Las contraseñas no coinciden.",
                "danger"
            )

            return render_template(
                "restablecer_password.html",
                token=token
            )

        if len(password) < 8:

            flash(
                "La contraseña debe tener al menos 8 caracteres.",
                "danger"
            )

            return render_template(
                "restablecer_password.html",
                token=token
            )

        usuario = reset_token.usuario
        usuario.set_password(password)
        reset_token.used = True

        db.session.commit()

        flash(
            "Tu contraseña ha sido actualizada correctamente.",
            "success"
        )

        return redirect(url_for("auth.login"))

    return render_template(
    "auth/restablecer_pass.html",
    token=token
)
