from flask import Blueprint, render_template, request, redirect, url_for, flash
from alchemyClasses import db
from flask_login import login_required, current_user
from alchemyClasses.Usuario import Usuario
from email_validator import validate_email, EmailNotValidError
import re


profile_bp = Blueprint("profile", __name__, url_prefix="/profile")

@profile_bp.route('/editar', methods = ['GET', 'POST'])
@login_required
def editar():
    if request.method == 'POST':
        nombre_usuario = request.form['nombre_usuario']
        email = request.form['email']
        telefono = request.form['telefono']
     
        if len(nombre_usuario) < 3:
            flash('El nombre de usuario debe tener al menos 3 caracteres', 'error')
            return render_template('profile/profile.html')  
        if not re.match(r'^\d{10}$', telefono):
            flash('El teléfono debe tener 10 dígitos', 'error')
            return render_template('profile/profile.html')
        try:
            validate_email(email)
        except EmailNotValidError:
            flash('Correo electrónico inválido', 'error')
            return render_template('profile/profile.html')
        usuario = Usuario.query.get(current_user.id)
        usuario.nombre_usuario = nombre_usuario
        usuario.email = email
        usuario.telefono = telefono
        db.session.commit()
        flash('Perfil actualizado correctamente', 'success')
        return redirect(url_for('profile.editar'))
    return render_template('profile/profile.html')