from flask import Blueprint, render_template, request, redirect, url_for, flash
import re
from alchemyClasses.Usuario import Usuario
from alchemyClasses import db
from email_validator import validate_email, EmailNotValidError
from flask_login import login_user, logout_user, login_required
from blueprints.role_views import anonymous_required
from extensions import limiter


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

@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Has cerrado sesión', 'success')
    return redirect(url_for('home.inicio'))
