from flask import Blueprint, render_template
from flask_login import login_required
from blueprints.role_views import anonymous_required

home_bp = Blueprint("home", __name__, url_prefix="/")

@home_bp.route('/')
@anonymous_required
def inicio():
    return render_template('landing.html')

@home_bp.route('/contacto')
def contacto():
    return render_template('contacto.html')

# Ruta del aviso de privacidad

@home_bp.route("/privacidad")
def privacidad():
    return render_template("privacy.html")


