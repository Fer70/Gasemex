from flask import Blueprint, render_template, redirect, url_for
from flask_login import login_required, current_user
from functools import wraps

role_views_bp = Blueprint("role_views", __name__, url_prefix="/dashboard")

@role_views_bp.route('/')
@login_required
def index():

    if current_user.is_admin:
        return redirect(url_for('admin.index'))

    return render_template(
        'dashboard/user.html'
    )

def anonymous_required(f):

    @wraps(f)
    def decorated_function(*args, **kwargs):

        if current_user.is_authenticated:
            return redirect(url_for('role_views.index'))

        return f(*args, **kwargs)

    return decorated_function

def admin_required(f):
    
    @wraps(f)
    def decorated_function(*args, **kwargs):

        if not current_user.is_authenticated or not current_user.is_admin:
            return redirect(url_for('role_views.index'))

        return f(*args, **kwargs)

    return decorated_function

def user_required(f):
    
    @wraps(f)
    def decorated_function(*args, **kwargs):

        if not current_user.is_authenticated or current_user.is_admin:
            return redirect(url_for('role_views.index'))

        return f(*args, **kwargs)

    return decorated_function

