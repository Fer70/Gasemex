from flask import Flask, session
from sqlalchemy import URL
import os
from dotenv import load_dotenv
from flask_mail import Mail
from alchemyClasses import db
from extensions import login_manager, mail, limiter
from config import Config
from werkzeug.security import generate_password_hash



from blueprints.auth import auth_bp
from blueprints.role_views import role_views_bp
from blueprints.home import home_bp
from blueprints.profile import profile_bp
from blueprints.products import products_bp
from blueprints.orders import orders_bp
from blueprints.admin import admin_bp

from alchemyClasses.Usuario import Usuario 

load_dotenv()  # Cargar variables de entorno desde el archivo .env

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    # Inicializar extensiones
    db.init_app(app)
    login_manager.init_app(app)
    mail.init_app(app) # Inicializar Flask-Mail
    limiter.init_app(app) # Inicializar Flask-Limiter

    # Registrar blueprints
    app.register_blueprint(auth_bp)
    app.register_blueprint(role_views_bp)
    app.register_blueprint(home_bp)
    app.register_blueprint(profile_bp)
    app.register_blueprint(products_bp)
    app.register_blueprint(orders_bp)
    app.register_blueprint(admin_bp)

    @login_manager.user_loader
    def load_user(user_id):
        return Usuario.query.get(int(user_id))
    @app.context_processor
    def carrito_context():
        carrito = session.get('carrito', {})
        carrito_count = sum(item['cantidad'] for item in carrito.values())
        return dict(carrito=carrito, carrito_count=carrito_count)


    return app
app = create_app()

@app.after_request
def agregar_headers_seguridad(response):
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-Frame-Options"] = "SAMEORIGIN"
    response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
    response.headers["Permissions-Policy"] = (
        "camera=(), microphone=(), geolocation=()"
    )
    response.headers["Strict-Transport-Security"] = (
        "max-age=31536000; includeSubDomains"
    )

    return response

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5002, debug=False)