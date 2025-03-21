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
    "rtsp://admin:2Mini001.@10.93.27.196/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.229/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.219/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.234/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.207/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.192/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.223/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.228/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.198/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.230/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.201/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.203/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.227/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.226/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.206/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.193/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.195/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.199/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.202/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.232/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.204/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.238/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.197/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.194/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.233/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.231/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.218/h264/ch1/sub/av_stream"  
    "rtsp://admin:2Mini001.@10.93.27.200/h264/ch1/sub/av_stream"
)

# Nombres de las cámaras
CAMARA_NOMBRES=(
    "CAJA_01_640"
    "CAJA_02_640" 
    "CAJA_03_640" 
    "CAJA_04_640"
    "CAJA_05_640"
    "CAJA_06_640"
    "CAJA_07_640"
    "CAJA_08_640"
    "CAJA_09_640"
    "CAJA_10_640"
    "CAJA_11_640"
    "CAJA_12_640"
    "CAJA_13_640"
    "CAJA_14_640"
    "CAJA_15_640"
    "CAJA_16_640"
    "CAJA_17_640"
    "CAJA_18_640"
    "CAJA_19_640"
    "CAJA_20_640"
    "CAJA_21_640"
    "CAJA_22_640"
    "CAJA_23_640"
    "CAJA_24_640"
    "CAJA_25_640"
    "CAJA_26_640"
    "CAJA_27_640"
    "CAJA_28_640"
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