

Este proyecto  es una plataforma web desarrollada para **Gases, Equipos y Soldaduras**, orientada a la venta en línea y gestión de productos relacionados con soldadura, gases industriales, consumibles y accesorios.

El sistema permite a los clientes consultar el catálogo, agregar productos al carrito, realizar pedidos, efectuar pagos en línea y consultar el estado de sus pedidos. Además, proporciona funcionalidades administrativas para gestionar productos, usuarios y pedidos.

El proyecto está diseñado como una aplicación web completa, con una arquitectura basada en **Flask + MySQL**, servicios de **Cloudflare** para infraestructura y almacenamiento de imágenes, y **Mercado Pago** para el procesamiento de pagos.

---

## Características principales

### Catálogo de productos

- Consulta de productos disponibles.
- Búsqueda de productos.
- Organización por categorías y tipos de producto.
- Información de precio, descripción y disponibilidad.
- Imágenes almacenadas mediante Cloudflare R2.
- Diseño responsive para dispositivos móviles y escritorio.

### Carrito de compras

Los usuarios pueden:

- Agregar productos al carrito.
- Incrementar o disminuir cantidades.
- Eliminar productos.
- Consultar subtotales.
- Consultar el total de la compra.
- Visualizar el número de productos en el carrito.

Parte de la interacción del carrito utiliza JavaScript/React de forma parcial para actualizar cantidades sin necesidad de recargar toda la página.

### Usuarios y autenticación

El sistema cuenta con:

- Registro de usuarios.
- Inicio y cierre de sesión.
- Autenticación mediante Flask-Login.
- Control de acceso basado en roles.
- Recuperación de contraseña mediante correo electrónico.
- Tokens de recuperación con expiración.
- Contraseñas almacenadas mediante hash seguro.

### Recuperación de contraseña

El flujo de recuperación funciona mediante un enlace temporal enviado al correo electrónico del usuario.

```text
Usuario
   │
   ▼
"¿Olvidaste tu contraseña?"
   │
   ▼
Ingresa correo
   │
   ▼
Generación de token
   │
   ▼
Token almacenado como hash
   │
   ▼
Correo con enlace
   │
   ▼
Usuario establece nueva contraseña
   │
   ▼
Token invalidado
```

Los tokens tienen un tiempo de expiración y solamente pueden utilizarse una vez.

---

## Proceso de compra

El proceso general de compra es:

```text
Catálogo
   │
   ▼
Seleccionar productos
   │
   ▼
Carrito
   │
   ▼
Dirección de envío
   │
   ▼
Checkout pendiente
   │
   ▼
Mercado Pago
   │
   ├── Pago aprobado
   │       │
   │       ▼
   │    Webhook
   │       │
   │       ▼
   │    Validación
   │       │
   │       ▼
   │     Pedido
   │
   ├── Pago pendiente
   │
   └── Pago rechazado
```

El pedido solamente se genera después de recibir y validar la confirmación del pago.

---

## Integración con Mercado Pago

La plataforma utiliza Mercado Pago para procesar los pagos en línea.

El sistema implementa:

- Creación de preferencias de pago.
- Identificación de cada checkout mediante una referencia externa.
- Redirección al checkout de Mercado Pago.
- Webhooks para recibir actualizaciones de pago.
- Validación de firma mediante HMAC.
- Validación del monto recibido.
- Prevención de procesamiento duplicado.
- Manejo de diferentes estados del pago.

El webhook recibe las notificaciones de Mercado Pago y valida que la información recibida corresponda con el checkout almacenado en la base de datos.

De esta manera, el navegador del cliente no es la fuente de confianza para determinar si un pedido fue pagado.

---

## Gestión de pedidos

Los pedidos almacenan información como:

- Usuario que realizó el pedido.
- Productos adquiridos.
- Dirección de envío.
- Total.
- Método de pago.
- Estado del pedido.
- Información relacionada con el pago.

Los pedidos pueden avanzar por diferentes estados durante el proceso de entrega.

Además, el sistema puede enviar notificaciones por correo electrónico cuando cambia el estado de un pedido.

---

## Envíos

El sistema permite registrar manualmente la dirección de entrega del cliente.

La información de envío contempla:

- Estado.
- Municipio/alcaldía.
- Colonia.
- Calle.
- Número.
- Código postal.
- Dirección completa asociada al pedido.

La plataforma está orientada principalmente a entregas en **Ciudad de México, Estado de México y determinadas zonas de Morelos**.

---

## Panel administrativo

Los usuarios con permisos administrativos pueden acceder a funcionalidades de administración.

Entre ellas:

- Gestión de productos.
- Consulta de pedidos.
- Actualización del estado de pedidos.
- Gestión de usuarios.
- Consulta de información relacionada con las ventas.

El acceso administrativo está protegido mediante control de roles.

---

# Arquitectura

La arquitectura general del sistema es:

```text
                         INTERNET
                            │
                            ▼
                    ┌─────────────────┐
                    │    Cloudflare   │
                    │ DNS / CDN / SSL │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │      Render     │
                    │  Flask + Gunicorn
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
          ┌────────┐    ┌──────────┐   ┌───────────┐
          │ MySQL  │    │ Mercado  │   │  Resend   │
          │Railway │    │  Pago    │   │  Email    │
          └────────┘    └──────────┘   └───────────┘
              │
              │
              ▼
        Datos de usuarios,
        productos, pedidos
        y pagos


                    Cloudflare R2
                         │
                         ▼
                  Imágenes de productos
```

### Componentes principales

| Componente | Tecnología | Función |
|---|---|---|
| Backend | Flask | Lógica de negocio y API |
| Frontend | Jinja2 + Bootstrap | Interfaz web |
| Interactividad | JavaScript / React | Componentes dinámicos |
| Base de datos | MySQL | Persistencia de información |
| ORM | SQLAlchemy | Acceso a base de datos |
| Autenticación | Flask-Login | Gestión de sesiones |
| Pagos | Mercado Pago | Procesamiento de pagos |
| Correo | Resend | Notificaciones y recuperación |
| Imágenes | Cloudflare R2 | Almacenamiento de imágenes |
| CDN / DNS | Cloudflare | Seguridad, DNS y distribución |
| Hosting | Render | Ejecución de la aplicación |

---

# Tecnologías utilizadas

## Backend

- Python
- Flask
- SQLAlchemy
- PyMySQL
- Flask-Login
- Flask-WTF
- Flask-Limiter
- Gunicorn

## Frontend

- HTML5
- CSS3
- JavaScript
- Jinja2
- Bootstrap 5
- Bootstrap Icons
- React para componentes específicos

## Servicios externos

- Cloudflare
- Cloudflare R2
- Railway
- Render
- Mercado Pago
- Resend

---

# Base de datos

El sistema utiliza MySQL como sistema de gestión de base de datos.

Entre las principales entidades se encuentran:

```text
Usuario
   │
   ├── Pedidos
   │
   └── Tokens de recuperación

Producto
   │
   └── Detalles de pedido

Pedido
   │
   ├── Usuario
   ├── Detalles
   └── Pago

Pago
   │
   └── Pedido

CheckoutPendiente
   │
   └── Proceso de pago
```

El acceso a la base de datos se realiza mediante SQLAlchemy y consultas parametrizadas, reduciendo el riesgo de inyección SQL.

---

# Seguridad

La aplicación implementa diferentes mecanismos de seguridad:

- Contraseñas almacenadas mediante hashing.
- Autenticación mediante Flask-Login.
- Protección CSRF.
- Consultas parametrizadas mediante SQLAlchemy.
- Control de acceso por roles.
- Rate limiting para endpoints sensibles.
- Tokens de recuperación almacenados mediante hash.
- Expiración de tokens de recuperación.
- Tokens de recuperación de un solo uso.
- Validación HMAC de webhooks de Mercado Pago.
- Validación del monto de los pagos.
- Protección contra procesamiento duplicado de webhooks.
- Cookies `HttpOnly`.
- Cookies `Secure`.
- Política `SameSite`.
- HTTPS.
- HSTS.
- Headers de seguridad HTTP.
- Almacenamiento de secretos mediante variables de entorno.

Ejemplo de variables utilizadas:

```text
DB_USER
DB_PASSWORD
DB_HOST
DB_PORT
DB_NAME

MP_ACCESS_TOKEN
MP_PUBLIC_KEY
MP_WEBHOOK_SECRET

RESEND_API_KEY
RESEND_FROM_EMAIL

R2_ACCOUNT_ID
R2_ACCESS_KEY_ID
R2_SECRET_ACCESS_KEY
R2_BUCKET_NAME
R2_PUBLIC_URL
```

> **Importante:** las credenciales, tokens y claves privadas nunca deben almacenarse en el repositorio.

---

# Almacenamiento de imágenes

Las imágenes de los productos se almacenan en **Cloudflare R2**.

La base de datos solamente almacena el nombre del archivo:

```text
6013.png
micalum.png
pv700.png
```

La aplicación construye la URL utilizando la configuración de R2.

Esto permite separar:

```text
Base de datos
     │
     └── información del producto

Cloudflare R2
     │
     └── archivos de imagen
```

La arquitectura también permite utilizar la CDN de Cloudflare para reducir las solicitudes directas al almacenamiento.

---

# Estructura general del proyecto

Una estructura aproximada del proyecto es:

```text
gasemex/
│
├── app/
│   ├── __init__.py
│   │
│   ├── auth/
│   ├── products/
│   ├── orders/
│   ├── admin/
│   │
│   ├── models/
│   ├── templates/
│   └── static/
│
├── migrations/
│
├── scripts/
│
├── .env
├── .gitignore
├── requirements.txt
├── run.py
└── README.md
```

La estructura exacta puede variar dependiendo de la versión actual del proyecto.

---

# Variables de entorno

Para ejecutar el proyecto localmente se deben configurar las variables de entorno correspondientes.

Ejemplo:

```env
DB_USER=
DB_PASSWORD=
DB_HOST=
DB_PORT=
DB_NAME=

MP_ACCESS_TOKEN=
MP_PUBLIC_KEY=
MP_WEBHOOK_SECRET=

RESEND_API_KEY=
RESEND_FROM_EMAIL=

R2_ACCOUNT_ID=
R2_ACCESS_KEY_ID=
R2_SECRET_ACCESS_KEY=
R2_BUCKET_NAME=
R2_PUBLIC_URL=

BASE_URL=
SECRET_KEY=
```

Los valores reales deben mantenerse fuera del repositorio.

---

# Ejecución local

## 1. Clonar el repositorio

```bash
git clone https://github.com/USUARIO/gasemex.git
cd gasemex
```

## 2. Crear entorno virtual

```bash
python3 -m venv .venv
source .venv/bin/activate
```

## 3. Instalar dependencias

```bash
pip install -r requirements.txt
```

## 4. Configurar variables de entorno

Crear un archivo:

```text
.env
```

con las variables necesarias para el entorno local.

## 5. Ejecutar la aplicación

Por ejemplo:

```bash
flask run
```

o utilizando el punto de entrada correspondiente al proyecto.

---

# Despliegue

La aplicación está diseñada para ejecutarse en un entorno de producción utilizando:

```text
GitHub
   │
   ▼
Render
   │
   ├── Flask / Gunicorn
   │
   └── Variables de entorno
          │
          ├── Railway → MySQL
          ├── Cloudflare → R2
          ├── Mercado Pago
          └── Resend
```

El dominio público se gestiona mediante Cloudflare.

---

# Flujo de información

Un ejemplo completo del flujo de compra es:

```text
1. Cliente entra a GASEMEX
        ↓
2. Consulta catálogo
        ↓
3. Selecciona productos
        ↓
4. Agrega productos al carrito
        ↓
5. Confirma dirección
        ↓
6. Se crea CheckoutPendiente
        ↓
7. Se genera preferencia de Mercado Pago
        ↓
8. Cliente realiza el pago
        ↓
9. Mercado Pago envía webhook
        ↓
10. GASEMEX valida la notificación
        ↓
11. Se valida el monto
        ↓
12. Se evita procesamiento duplicado
        ↓
13. Checkout pasa a "pagado"
        ↓
14. Se genera el Pedido
        ↓
15. Se actualiza el inventario
        ↓
16. Se notifica al cliente
        ↓
17. Se gestiona la entrega
```

---

# Objetivos del proyecto

El proyecto busca proporcionar a GASEMEX una plataforma que permita:

- Digitalizar el proceso de venta.
- Facilitar la consulta del catálogo.
- Permitir compras en línea.
- Automatizar la confirmación de pagos.
- Centralizar la gestión de pedidos.
- Reducir procesos manuales.
- Proporcionar una experiencia adecuada para dispositivos móviles.
- Mantener una arquitectura escalable y segura.

---

# Trabajo futuro

Algunas funcionalidades consideradas para futuras versiones:

- Paginación avanzada del catálogo.
- Mejoras de caché para productos públicos.
- Conversión automática de imágenes a WebP/AVIF.
- Optimización SEO.
- Sitemap automático.
- Datos estructurados para productos.
- Integración con Google Search Console.
- Notificaciones mediante SMS.
- Sistema de facturación.
- Mejoras en el manejo de reembolsos y contracargos.
- Detección automática de cilindros mediante visión artificial.
- Identificación y clasificación de diferentes tipos de cilindros.
- Mejoras en el panel administrativo y estadísticas de ventas.

---

# Estado del proyecto

**Estado:** En desarrollo / preparación para producción.

La plataforma cuenta con los componentes principales de autenticación, catálogo, carrito, checkout, pagos, pedidos, almacenamiento de imágenes, correo electrónico y despliegue en la nube.

---

## Autor

**Fernando Ocampo Tovar**

Proyecto desarrollado para **GASEMEX — Gases, Equipos y Soldaduras**.
