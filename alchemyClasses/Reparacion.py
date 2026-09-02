from sqlalchemy import Column, Integer, String, ForeignKey, DateTime
from alchemyClasses import db

class Reparacion(db.Model):
    __tablename__ = 'Reparacion'
    id_reparacion = db.Column(db.Integer, primary_key=True)
    id_usuario = db.Column(db.Integer, db.ForeignKey('Usuario.id_usuario'), nullable=False)
    nombre_reparacion = db.Column(db.String(255), nullable=False)
    fecha_reparacion = db.Column(db.DateTime, default=db.func.current_timestamp())
    estado_reparacion = db.Column(db.String(255), nullable=False)
    descripcion_reparacion = db.Column(db.String(255), nullable=False, default='Sin descripción')
    usuario = db.relationship(
        "Usuario",
        back_populates="reparaciones"
    )