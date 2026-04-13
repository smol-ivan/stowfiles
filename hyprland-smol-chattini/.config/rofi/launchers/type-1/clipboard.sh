dir="$HOME/.config/rofi/launchers/type-1"
theme='style-3'

## Run
rofi \
    -dmenu 
    -display-columns 2 \
    -p "Search" \
    -theme ${dir}/${theme}.rasi
