import os
import argparse
import logging
from boto3.session import Session
from dotenv import load_dotenv

logging.basicConfig(level=logging.INFO)

load_dotenv()

session = Session(
    aws_access_key_id=os.getenv("AWS_ACCESS_KEY"),
    aws_secret_access_key=os.getenv("AWS_SECRET_KEY"),
)
s3 = session.client("s3")


def download_from_s3(bucket_name, bucket_path, local_download_path):
    """Descarga un archivo .zip desde un bucket de AWS S3."""
    os.makedirs(os.path.dirname(local_download_path), exist_ok=True)

    logging.info(
        f"Descargando s3://{bucket_name}/{bucket_path} a {local_download_path}"
    )
    s3.download_file(bucket_name, bucket_path, local_download_path)
    logging.info("Descarga completada.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Descargar archivo .zip desde S3")
    parser.add_argument("--bucket_name", required=True, help="Nombre del bucket de S3")
    parser.add_argument(
        "--bucket_path",
        required=True,
        help="Ruta dentro del bucket de S3 del archivo .zip",
    )
    parser.add_argument(
        "--local_download_path",
        required=True,
        help="Ruta local donde se guardará el archivo descargado",
    )

    args = parser.parse_args()

    download_from_s3(args.bucket_name, args.bucket_path, args.local_download_path)
