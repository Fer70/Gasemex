from sqlalchemy import Column, Integer, String, ForeignKey, DateTime
from alchemyClasses import db

class Pago(db.Model):
    __tablename__ = "Pago"

    id_pago = db.Column(
        db.Integer,
        primary_key=True
    )

    id_pedido = db.Column(
        db.Integer,
        db.ForeignKey("Pedido.id_pedido"),
        nullable=False,
        unique=True
    )

    metodo_pago = db.Column(
        db.String(50),
        nullable=False
    )

    estado_pago = db.Column(
        db.String(30),
        nullable=False,
        default="Pendiente"
    )

    id_transaccion = db.Column(
        db.String(150),
        nullable=True
    )

    fecha_pago = db.Column(
        db.DateTime,
        nullable=True
    )

    monto = db.Column(
        db.Numeric(10,2),
        nullable=False
    )

    pedido = db.relationship(
        "Pedido",
        back_populates="pago"
    )
