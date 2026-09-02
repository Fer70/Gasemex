from flask_login import UserMixin
from alchemyClasses import db
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

class Usuario(db.Model, UserMixin):
    __tablename__ = 'Usuario'
    id_usuario = db.Column(db.Integer, primary_key=True)
    nombre_usuario = db.Column(db.String(255), nullable=False)
    contrasena_usuario = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), unique=True, nullable=False)
    telefono = db.Column(db.String(255), nullable=True)
    puntos = db.Column(db.Integer, nullable = False, default = 0)
    rol = db.Column(db.String(255), nullable=False, default='cliente')
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp()) 
    pedidos = db.relationship(
    "Pedido",
    back_populates="usuario",
    lazy=True
    )  
    reparaciones = db.relationship(
        "Reparacion",
        back_populates="usuario",
        lazy=True
    )

    def set_password(self, password):
        self.contrasena_usuario = generate_password_hash(password)
        
    def check_password(self, password):
        return check_password_hash(self.contrasena_usuario, password)

    @property
    def id(self):
        return self.id_usuario
    
    @property
    def fecha_registro(self):
        return self.created_at.strftime("%d/%m/%Y")
    
    @property
    def is_admin(self):
        return self.rol == 'admin'

    
        
