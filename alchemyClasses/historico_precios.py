from sqlalchemy import Column, Integer, String, Numeric, ForeignKey, DateTime
from alchemyClasses import db

class historico_precios(db.Model):
    __tablename__ = 'historico_precios'
    id_historico = db.Column(db.Integer, primary_key=True)
    id_producto = db.Column(db.Integer, db.ForeignKey('Producto.id_producto'), nullable=False)
    precio = db.Column(db.Numeric(10, 2), nullable=False)
    fecha_cambio = db.Column(db.DateTime, default=db.func.current_timestamp())
