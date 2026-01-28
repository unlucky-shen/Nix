#!/bin/sh

entries="1. Suspend\n2. Restart\n3. Power Off"

selected=$(echo -e $entries | wofi --dmenu --cache-file /dev/null | awk '{print $2}')

case $selected in
  Suspend)
    systemctl suspend ;;
  Restart)
    systemctl reboot ;;
  "Power")
    systemctl poweroff ;;
esac
