from sqlalchemy import Column, Integer, String, Numeric, ForeignKey, DateTime
from alchemyClasses import db

class Producto(db.Model):
    __tablename__ = 'Producto'
    id_producto = db.Column(db.Integer, primary_key=True)
    nombre_producto = db.Column(db.String(255), nullable=False)
    descripcion_producto = db.Column(db.String(2000), nullable=True)
    precio = db.Column(db.Numeric(10, 2), nullable=False)
    stock = db.Column(db.Integer, nullable=False)
    imagen = db.Column(db.String(255), nullable=True, default='default.png')
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp())
    tipo_fk = db.Column(db.Integer, db.ForeignKey('Tipo.id_tipo'), nullable=False)
    is_active = db.Column(db.Boolean, nullable=False, default=True)
    
