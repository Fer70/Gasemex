from sqlalchemy import Column, Integer, String, Numeric, ForeignKey, DateTime
from alchemyClasses import db

class Tipo(db.Model):
    __tablename__ = 'Tipo'
    id_tipo = db.Column(db.Integer, primary_key=True)
    nombre_tipo = db.Column(db.String(50), nullable=False)

        