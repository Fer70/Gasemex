from alchemyClasses import db
from sqlalchemy import Column, Integer, String, ForeignKey, Numeric, Text


class CheckoutPendiente(db.Model):
    __tablename__ = "CheckoutPendiente"

    id_checkout = db.Column(db.Integer, primary_key=True)
    id_usuario = db.Column(db.Integer, db.ForeignKey("Usuario.id_usuario"), nullable=False)
    direccion_envio = db.Column(db.String(255), nullable=False)
    carrito_json = db.Column(db.Text, nullable=False)
    total = db.Column(db.Numeric(10, 2), nullable=False)
    monto = db.Column(db.Numeric(10,2), nullable = False)

    estado = db.Column(db.String(30), nullable=False, default="pendiente")
