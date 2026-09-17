from flask import Blueprint, render_template, request, redirect, url_for, session, flash
from flask_login import login_required
from alchemyClasses.Producto import Producto
from alchemyClasses.Tipo import Tipo
from sqlalchemy import or_
from blueprints.role_views import user_required
from extensions import limiter

products_bp = Blueprint('products', __name__, url_prefix='/products')

SUBCATEGORIAS = {
    'Soldaduras': [
        ('electrodos', 'Electrodos'),
        ('microalambre', 'Microalambre'),
        ('varillas', 'Varillas'),
        ('tungstenos', 'Tungstenos'),
        ('productos-soldar', 'Productos para soldar')
    ],
    'Consumibles': [
        ('mig', 'MIG'),
        ('tig', 'TIG'),
        ('mma', 'MMA')
    ],
    'Abrasivos': [
        ('corte', 'Corte'),
        ('desbaste', 'Desbaste')
    ],
    'Equipos': [
        ('maquinas', 'Máquinas'),
        ('autogena', 'Autógena'),
        ('reguladores', 'Reguladores'),
        ('antorchas', 'Antorchas'),
        ('equipos-de-soldar/cortar ', 'Equipos de soldar/cortar'),
        ('accesorios', 'Accesorios')
    ]
}


@products_bp.route('/')
@login_required
def index():

    categorias = Tipo.query.all()

    return render_template(
        'products/index.html',
        categorias=categorias
    )

@products_bp.route('/categoria/<nombre>')
@login_required
def categoria(nombre):

    subcategorias = SUBCATEGORIAS.get(nombre, [])
    productos = Producto.query.join(Tipo).filter(Tipo.nombre_tipo == nombre, Producto.is_active == True).order_by(Producto.nombre_producto).all()

    return render_template(
        'products/categoria.html',
        categoria=nombre,
        subcategorias=subcategorias,
        productos=productos,
        subcategoria_activa=''
    )

@products_bp.route('/categoria/<categoria>/tipo/<tipo>')
def subcategoria(categoria, tipo):
    palabras_clave = {
        'electrodos': ['electrodo', '7018', '6010', '6011', '6013', '7024'],
        'microalambre': ['microalambre', 'mig'],
        'varillas': ['varilla'],
        'tungstenos': ['tungsteno'],
        'productos-soldar':['líquido', 'para', 'gel', 'spray', 'decapante'],

        'mig': ['mig', 'tobera', 'punta', 'difusor'],
        'tig': ['tig', 'copa', 'espiga', 'porta'],
        'mma': ['mma', 'pinza', 'portaelectrodo', 'cable', 'masa'],

        'corte': ['corte', 'cortar'],
        'desbaste': ['desbaste', 'desbastar'],

        'maquinas': ['rogue', 'redbo', 'lhn', '250', 'bufalito', '350', 'cutmaster', 'power', 'adir', '130', '200'],
        'autogena': ['soplete', 'cortador', 'tortuga'],
        'reguladores': ['regulador', 'manometro', 'valvula'],
        'antorchas': ['antorcha'],
        'equipos-de-soldadura': ['equipo'],
        'accesorios': ['portaelectrodo', 'pinza', 'cable','horno', 'manguera']
    }

    palabras = palabras_clave.get(tipo, [])

    condiciones = []

    for palabra in palabras:
        condiciones.append(Producto.nombre_producto.ilike(f'%{palabra}%'))

    productos = Producto.query.filter(or_(*condiciones), Producto.is_active == True).order_by(Producto.nombre_producto).all()
    tipo = tipo.upper() if tipo else ''

    return render_template(
        'products/subcategoria.html',
        categoria=categoria,
        productos=productos,
        subcategorias=SUBCATEGORIAS.get(categoria, []),
        subcategoria_activa=tipo
    )

@products_bp.route('/agregar/<int:id_producto>')
@login_required
def agregar_carrito(id_producto):

    producto = Producto.query.get_or_404(id_producto)

    carrito = session.get('carrito', {})

    id_str = str(id_producto)

    if id_str in carrito:

        carrito[id_str]['cantidad'] += 1

    else:

        carrito[id_str] = {
            'nombre': producto.nombre_producto,
            'precio': float(producto.precio),
            'cantidad': 1,
            'imagen': producto.imagen
        }

    session['carrito'] = carrito

    flash(
        'Producto agregado al carrito',
        'success'
    )

    return redirect(request.referrer or '/products')

@products_bp.route('/buscar')
@login_required
@limiter.limit("15 per minute")  # Limitar a 15 solicitudes por minuto
def buscar():
    query = request.args.get('q', '').strip()

    productos = Producto.query.filter(
        Producto.nombre_producto.ilike(f'%{query}%'), Producto.is_active == True
    ).all()

    return render_template(
        'products/productos.html',
        productos=productos,
        busqueda=query
    )

@products_bp.route('/carrito')
@login_required
@user_required
def carrito():

    carrito = session.get('carrito', {})

    total = 0

    for item in carrito.values():

        total += (
            item['precio']
            * item['cantidad']
        )
    hay_gas = False
    for item in carrito.values():
        producto = Producto.query.filter_by(nombre_producto=item['nombre'], is_active=True).first()
        if producto and producto.tipo_fk == 1:
            hay_gas = True
            break

    
    return render_template(
        'products/carrito.html',
        carrito=carrito,
        total=total,
        hay_gas=hay_gas
    )
@products_bp.route('/carrito/aumentar/<int:id_producto>')
@login_required
def aumentar_producto(id_producto):

    carrito = session.get('carrito', {})

    id_str = str(id_producto)

    if id_str in carrito:

        carrito[id_str]['cantidad'] += 1

        session['carrito'] = carrito

    return redirect(url_for('products.carrito'))

@products_bp.route('/carrito/disminuir/<int:id_producto>')
@login_required
def disminuir_producto(id_producto):

    carrito = session.get('carrito', {})

    id_str = str(id_producto)

    if id_str in carrito:

        carrito[id_str]['cantidad'] -= 1

        if carrito[id_str]['cantidad'] <= 0:

            del carrito[id_str]

        session['carrito'] = carrito

    return redirect(url_for('products.carrito'))

@products_bp.route('/carrito/eliminar/<int:id_producto>')
@login_required
def eliminar_producto(id_producto):

    carrito = session.get('carrito', {})

    id_str = str(id_producto)

    if id_str in carrito:

        del carrito[id_str]

        session['carrito'] = carrito

        flash(
            'Producto eliminado del carrito',
            'warning'
        )

    return redirect(url_for('products.carrito'))

@products_bp.route('/ofertas')
@login_required
def ofertas():

    productos = Producto.query.filter(
        Producto.tipo_fk == 10, Producto.is_active == True
    ).all()

    return render_template(
        'products/ofertas.html',
        productos=productos
    )
