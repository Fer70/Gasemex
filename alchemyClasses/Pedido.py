from sqlalchemy import Column, Integer, String, ForeignKey, DateTime
from alchemyClasses import db


class Pedido(db.Model):
    __tablename__ = 'Pedido'
    id_pedido = db.Column(db.Integer, primary_key=True)
    id_usuario = db.Column(db.Integer, db.ForeignKey('Usuario.id_usuario'), nullable=False)
    fecha_pedido = db.Column(db.DateTime, default=db.func.current_timestamp())
    direccion_envio = db.Column(db.String(255), nullable=False)
    estado_pedido = db.Column(db.String(255), nullable=False)
    total = db.Column(db.Numeric(10, 2), nullable=False)
    factura = db.Column(db.Boolean, nullable=False, default=False) 
    puntos_generado = db.Column(db.Integer, nullable = False)
    puntos_usados = db.Column (db.Integer, nullable = False) 
    usuario = db.relationship(
        "Usuario",
        back_populates="pedidos"
    )

    pago = db.relationship(
        "Pago",
        back_populates="pedido",
        uselist=False,
        cascade="all, delete-orphan"
    )
    detalle = db.relationship(
        "producto_pedido",
        back_populates="pedido",
        cascade="all, delete-orphan"
    )
