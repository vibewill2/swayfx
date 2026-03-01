#!/bin/sh

while true; do
  # CPU: Pega a carga média de 1 minuto
  CPU=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | tr -d ' ')

  # MEMÓRIA: Calcula a porcentagem de uso (NOVO)
  MEM=$(free | grep Mem | awk '{printf "%.0f%%", $3/$2 * 100}')

  # Volume: Extrai apenas o primeiro conjunto de números seguido de %
  VOL=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -o "[0-9]\+%" | head -1)
  
  # Se o volume estiver vazio (ex: mudo), coloca 0%
  [ -z "$VOL" ] && VOL="0%"

  # Data
  DATE=$(date +'%d/%m/%Y %H:%M')

  # Saída com o novo ícone de Memória 💾
  echo " $CPU | 💾 $MEM |  $VOL |  $DATE"
  
  sleep 1
done