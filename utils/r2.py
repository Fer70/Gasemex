import os
import boto3

R2_ACCOUNT_ID = os.getenv("R2_ACCOUNT_ID")
R2_ACCESS_KEY_ID = os.getenv("R2_ACCESS_KEY_ID")
R2_SECRET_ACCESS_KEY = os.getenv("R2_SECRET_ACCESS_KEY")
R2_BUCKET_NAME = os.getenv("R2_BUCKET_NAME")
R2_PUBLIC_URL = os.getenv("R2_PUBLIC_URL")

r2_client = boto3.client(
    "s3",
    endpoint_url=f"https://{R2_ACCOUNT_ID}.r2.cloudflarestorage.com",
    aws_access_key_id=R2_ACCESS_KEY_ID,
    aws_secret_access_key=R2_SECRET_ACCESS_KEY,
    region_name="auto"
)

def subir_imagen(file, nombre_archivo, content_type):
    r2_client.upload_fileobj(
        file,
        R2_BUCKET_NAME,
        nombre_archivo,
        ExtraArgs={
            "ContentType": content_type
        }
    )

    return f"{R2_PUBLIC_URL}/{nombre_archivo}"

def probar_r2():
    contenido = b"Prueba de conexion con Cloudflare R2"

    r2_client.put_object(
        Bucket=R2_BUCKET_NAME,
        Key="test/conexion.txt",
        Body=contenido,
        ContentType="text/plain"
    )

    return f"{R2_PUBLIC_URL}/test/conexion.txt"