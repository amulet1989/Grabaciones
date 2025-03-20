import os
import zipfile
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


def compress_folder(local_folder_path, output_zip_path):
    """Comprime una carpeta en un archivo zip."""
    logging.info(f"Comprimiendo carpeta: {local_folder_path}")
    with zipfile.ZipFile(output_zip_path, "w", zipfile.ZIP_DEFLATED) as zipf:
        for root, _, files in os.walk(local_folder_path):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, local_folder_path)
                zipf.write(file_path, arcname)
    logging.info(f"Archivo zip creado: {output_zip_path}")
    return output_zip_path


def upload_to_s3(zip_path, bucket_name, bucket_path):
    """Sube un archivo zip a un bucket de AWS S3."""
    s3_key = f"{bucket_path}/{os.path.basename(zip_path)}"
    logging.info(f"Subiendo {zip_path} a s3://{bucket_name}/{s3_key}")
    s3.upload_file(zip_path, bucket_name, s3_key)
    logging.info("Subida completada.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Comprimir carpeta y subir a S3")
    parser.add_argument("--bucket_name", required=True, help="Nombre del bucket de S3")
    parser.add_argument(
        "--bucket_path", required=True, help="Ruta dentro del bucket de S3"
    )
    parser.add_argument(
        "--local_folder_path",
        required=True,
        help="Ruta de la carpeta local a comprimir",
    )
    parser.add_argument(
        "--output_zip_path", default="output.zip", help="Ruta del archivo zip generado"
    )

    args = parser.parse_args()

    zip_file = compress_folder(args.local_folder_path, args.output_zip_path)
    upload_to_s3(zip_file, args.bucket_name, args.bucket_path)
