#!/bin/bash

# Duración en minutos
# DURACION_MINUTOS=1

# Convertir duración a segundos
DURACION_SEGUNDOS=120

# Obtener la fecha y hora actual en el formato "YYYY-MM-DD_HH-MM-SS"
FECHA_HORA=$(date +"%Y-%m-%d_%H-%M-%S")

# Directorio de salida
DIRECTORIO_SALIDA="videos/grabaciones_${FECHA_HORA}"
mkdir -p "$DIRECTORIO_SALIDA"

# Lista de URL RTSP de las camaras gondolas
RTSP_URLS=(
    "rtsp://admin:2Mini001.@10.93.27.240/live1"  
    "rtsp://admin:2Mini001.@10.93.27.241/live1" 
    "rtsp://admin:2Mini001.@10.93.27.242/live1" 
    "rtsp://admin:2Mini001.@10.93.27.243/live1" 
    "rtsp://admin:2Mini001.@10.93.27.244/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.245/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.246/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.247/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.248/h264/ch1/sub/av_stream"      
)

# Nombres de las cámaras
CAMARA_NOMBRES=(
    "QM_01_640"
    "QM_02_640" 
    "QM_03_640" 
    "QM_04_640"
    "QM_05_640"
    "QM_06_640"
    "QM_07_640"
    "QM_08_640"
    "QM_09_640" 
)

# Comenzar la grabación en paralelo para cada cámara
for i in "${!RTSP_URLS[@]}"; do
    URL="${RTSP_URLS[$i]}"
    NOMBRE_CAMARA="${CAMARA_NOMBRES[$i]}"
    OUTPUT="${DIRECTORIO_SALIDA}/${NOMBRE_CAMARA}_${FECHA_HORA}.mp4"
    
    # Grabar en H264 (MP4) a 10 fps
    ffmpeg -rtsp_transport tcp -i "$URL" -t "$DURACION_SEGUNDOS" -r 10 -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 192k "$OUTPUT" &
done

# Esperar a que todas las grabaciones finalicen
wait

echo "Grabación completada para todas las cámaras."