#!/bin/bash

PREVIOUS_ORIENTATION=""

monitor-sensor | while read -r line; do
    if echo "$line" | grep -q "Accelerometer orientation changed:"; then
        ORIENTATION=$(echo "$line" | awk -F': ' '{print $2}')
        
        if [ "$ORIENTATION" != "$PREVIOUS_ORIENTATION" ]; then
            case "$ORIENTATION" in
                "normal")
                    hyprctl keyword monitor ,transform,0
                    hyprctl keyword device:wacom-hid-527e-pen:transform 0
                    hyprctl keyword device:wacom-hid-527e-finger:transform 0
                    ;;
                "right-up")
                    # hyprctl keyword monitor ,transform,1
                    # hyprctl keyword device:wacom-hid-527e-pen:transform 1
                    # hyprctl keyword device:wacom-hid-527e-finger:transform 1
                    hyprctl keyword monitor ,transform,3
                    hyprctl keyword device:wacom-hid-527e-pen:transform 3
                    hyprctl keyword device:wacom-hid-527e-finger:transform 3
                    ;;
                "bottom-up")
                    hyprctl keyword monitor ,transform,2
                    hyprctl keyword device:wacom-hid-527e-pen:transform 2
                    hyprctl keyword device:wacom-hid-527e-finger:transform 2
                    ;;
                "left-up")
                    # hyprctl keyword monitor ,transform,3
                    # hyprctl keyword device:wacom-hid-527e-pen:transform 3
                    # hyprctl keyword device:wacom-hid-527e-finger:transform 3
                    hyprctl keyword monitor ,transform,1
                    hyprctl keyword device:wacom-hid-527e-pen:transform 1
                    hyprctl keyword device:wacom-hid-527e-finger:transform 1
                    ;;
            esac
            PREVIOUS_ORIENTATION="$ORIENTATION"
        fi
    fi
done
