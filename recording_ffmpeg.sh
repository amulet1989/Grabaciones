#!/bin/bash

# Duración en minutos
# DURACION_MINUTOS=1

# Convertir duración a segundos
DURACION_SEGUNDOS=30

# Directorio de salida
DIRECTORIO_SALIDA="videos/grabaciones"
mkdir -p "$DIRECTORIO_SALIDA"

# Lista de URL RTSP de las camaras gondolas
RTSP_URLS=(
    "rtsp://admin:2Mini001.@10.93.27.196"
    "rtsp://admin:2Mini001.@10.20.2.229"
)

# Nombres de las cámaras
CAMARA_NOMBRES=(
    "CAJA_01_1280x720"
    "CAJA_02_1280x720" 
)
# Obtener la fecha y hora actual en el formato "YYYY-MM-DD_HH-MM-SS"
FECHA_HORA=$(date +"%Y-%m-%d_%H-%M-%S")

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