from alchemyClasses import db

class PasswordResetToken(db.Model):
    id_pass = db.Column(db.Integer, primary_key=True)

    id_usuario = db.Column(
        db.Integer,
        db.ForeignKey("Usuario.id_usuario"),
        nullable=False
    )

    token_hash = db.Column(
        db.String(128),
        nullable=False,
        unique=True
    )

    expires_at = db.Column(
        db.DateTime,
        nullable=False
    )

    used = db.Column(
    db.Boolean,
    default=False,
    nullable=False
)

    created_at = db.Column(
    db.DateTime,
    default=db.func.current_timestamp(),
    nullable=False
)

    usuario = db.relationship(
    "Usuario",
    backref=db.backref(
        "password_reset_tokens",
        lazy=True
    )
)