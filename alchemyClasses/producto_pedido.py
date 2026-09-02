from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, Numeric
from alchemyClasses import db

class producto_pedido(db.Model):
    __tablename__ = 'producto_pedido'
    id_pedido = db.Column(db.Integer, db.ForeignKey('Pedido.id_pedido'), primary_key=True)
    id_producto = db.Column(db.Integer, db.ForeignKey('Producto.id_producto'), primary_key=True)
    cantidad = db.Column(db.Integer, nullable=False)
    precio_unitario = db.Column(db.Numeric(10,2), nullable = False)
    producto = db.relationship('Producto', backref=db.backref('producto_pedido', lazy=True))
    pedido = db.relationship('Pedido', back_populates='detalle')
