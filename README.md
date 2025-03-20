## Upload to AWS S3

AWS_BUCKET = "datasetsymodelos"

AWS_FILE_PATH = "videos_carrefour_vicente_lopez/

python upload_s3.py --bucket_name datasetsymodelos --bucket_path videos_carrefour_vicente_lopez --local_folder_path ./videos/grabaciones --output_zip_path ./videos/grabaciones.zip


## Grabar videos

bash recording_ffmpeg.sh