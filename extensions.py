from flask_login import LoginManager
from flask_mail import Mail
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

login_manager = LoginManager()
mail = Mail()

limiter = Limiter(
    key_func=get_remote_address,
    default_limits=["200 per day", "50 per hour"]
)

login_manager.login_view = 'auth.login'
login_manager.login_message = (
    'Debes iniciar sesión para acceder.'
)
login_manager.login_message_category = 'warning'