SCREEN=`xrandr | grep '*' | awk '{print $1}'`
SCREEN_X=${SCREEN%x*}
SCREEN_Y=${SCREEN#*x}
BORDER=`bspc config border_width`
GAP=$(cat ~/.config/bspwm/bspwmrc | grep "gap=" | sed 's/^.*=//')
H1=$(( SCREEN_Y - 28 - 2*GAP ))
H2=$(( (H1 - GAP)/2 ))
L1=$(( SCREEN_X-2*GAP ))
L2=$(( (L1 - GAP)/2  ))

X1=$GAP
X2=$(( SCREEN_X - GAP -L2 ))
Y1=$(( GAP+28 ))
Y2=$(( SCREEN_Y - GAP -H2  ))

sed -i "s/X1=.*/X1=$X1/g" ~/.config/bspwm/scripts/resize
sed -i "s/X2=.*/X2=$X2/g" ~/.config/bspwm/scripts/resize 
sed -i "s/Y1=.*/Y1=$Y1/g" ~/.config/bspwm/scripts/resize 
sed -i "s/Y2=.*/Y2=$Y2/g" ~/.config/bspwm/scripts/resize 
sed -i "s/L1=.*/L1=$L1/g" ~/.config/bspwm/scripts/resize 
sed -i "s/L2=.*/L2=$L2/g" ~/.config/bspwm/scripts/resize 
sed -i "s/H1=.*/H1=$H1/g" ~/.config/bspwm/scripts/resize 
sed -i "s/H2=.*/H2=$H2/g" ~/.config/bspwm/scripts/resize 
sed -i "s/GAP=.*/GAP=$GAP/g" ~/.config/bspwm/scripts/resize 
sed -i "s/SCREEN_X=.*/SCREEN_X=$SCREEN_X/g" ~/.config/bspwm/scripts/resize 
sed -i "s/SCREEN_Y=.*/SCREEN_Y=$SCREEN_Y/g" ~/.config/bspwm/scripts/resize 
