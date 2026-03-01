#!/bin/sh
while true; do
  # CPU: Pega a carga média de 1 minuto (uptime)
  CPU=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | tr -d ' ')

  # Volume: Extrai apenas o primeiro conjunto de números seguido de %
  VOL=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -o "[0-9]\+%" | head -1)
  
  # Se o volume estiver vazio (ex: mudo), coloca 0%
  [ -z "$VOL" ] && VOL="0%"

  # Data
  DATE=$(date +'%d/%m/%Y %H:%M')

  # O echo agora força a exibição do texto
  echo " $CPU |  $VOL |  $DATE"
  
  sleep 1
done
