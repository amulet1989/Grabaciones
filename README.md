## Upload to AWS S3

AWS_BUCKET = "datasetsymodelos"

AWS_FILE_PATH = "videos_carrefour_vicente_lopez/

python upload_s3.py --bucket_name datasetsymodelos --bucket_path videos_carrefour_vicente_lopez --local_folder_path ./videos/grabaciones --output_zip_path ./videos/grabaciones.zip

python download_s3.py --bucket_name datasetsymodelos --bucket_path videos_carrefour_vicente_lopez/grabaciones_2025-03-27_13-00-11.zip --local_download_path ./videos/grabaciones_2025-03-27_13-00-11.zip


## Grabar videos

bash recording_ffmpeg.sh