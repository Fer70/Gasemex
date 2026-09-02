from alchemyClasses import db

class Factura(db.Model):
    __tablename__ = "Factura"

    id_factura = db.Column(db.Integer, primary_key=True)
    rfc = db.Column(db.String(13), nullable=False)
    razon_social = db.Column(db.String(255), nullable=False)
    codigo_postal = db.Column(db.String(5), nullable=False)
    regimen_fiscal = db.Column(db.String(255), nullable=False)
    uso_cfdi = db.Column(db.String(255), nullable=False)
    correo = db.Column(db.String(255), nullable=False)
    fecha_factura = db.Column(db.DateTime, default=db.func.current_timestamp())
    id_pedido = db.Column(db.Integer, db.ForeignKey("Pedido.id_pedido"), nullable=False, unique=True)