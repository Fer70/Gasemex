import os
import mimetypes
from pathlib import Path
from utils.r2 import r2_client, R2_BUCKET_NAME
 # Cargar variables de entorno desde el archivo .env


# Carpeta donde actualmente tienes las imágenes
CARPETA_IMAGENES = Path("static/uploads/products")

# Carpeta dentro de R2
CARPETA_R2 = "products"


def existe_en_r2(nombre_archivo):
    key = f"{CARPETA_R2}/{nombre_archivo}"

    try:
        r2_client.head_object(
            Bucket=R2_BUCKET_NAME,
            Key=key
        )
        return True

    except Exception:
        return False


def migrar_imagenes():

    if not CARPETA_IMAGENES.exists():
        print(f"No existe la carpeta: {CARPETA_IMAGENES}")
        return

    extensiones = {
        ".png",
        ".jpg",
        ".jpeg",
        ".webp",
        ".gif"
    }

    imagenes = [
        archivo
        for archivo in CARPETA_IMAGENES.iterdir()
        if archivo.is_file()
        and archivo.suffix.lower() in extensiones
    ]

    print(f"Imágenes encontradas: {len(imagenes)}")
    print("R2_BUCKET_NAME:", R2_BUCKET_NAME)

    subidas = 0
    existentes = 0
    errores = 0

    for archivo in imagenes:

        nombre = archivo.name
        key = f"{CARPETA_R2}/{nombre}"

        print(f"\nProcesando: {nombre}")

        try:

            if existe_en_r2(nombre):
                print("→ Ya existe en R2, se omite.")
                existentes += 1
                continue

            content_type, _ = mimetypes.guess_type(str(archivo))

            if content_type is None:
                content_type = "application/octet-stream"

            with open(archivo, "rb") as file:

                r2_client.upload_fileobj(
                    file,
                    R2_BUCKET_NAME,
                    key,
                    ExtraArgs={
                        "ContentType": content_type
                    }
                )

            print(f"✓ Subida: {key}")
            subidas += 1

        except Exception as e:
            print(f"✗ Error: {e}")
            errores += 1

    print("\n==============================")
    print("MIGRACIÓN TERMINADA")
    print("==============================")
    print(f"Subidas:    {subidas}")
    print(f"Existentes: {existentes}")
    print(f"Errores:    {errores}")


if __name__ == "__main__":
    migrar_imagenes()