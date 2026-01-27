#!/bin/sh

entries=" Suspend\n  Restart\n  Power Off"

selected=$(echo -e $entries | wofi --dmenu --cache-file /dev/null | awk '{print $2}')

case $selected in
  Suspend)
    systemctl suspend ;;
  Restart)
    systemctl reboot ;;
  "Power")
    systemctl poweroff ;;
esac
