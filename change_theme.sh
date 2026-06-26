#!/bin/bash

STORE_DIR='/home/morph/.background'
if [ -z $1  ]; then
	echo "No command were specified";
	exit 1
fi
commands=("set" "clear" "all")
command=$1
if [[ ! " ${commands[@]} " =~ " ${command} " ]]; then
	echo "There is no command like this";
	exit 1;
fi
if [ $1 = 'all' ]; then
	echo "Themes available:"
	for file in $STORE_DIR/*
	do
		some="$(ls $file)"
		some=${some##*/}
		some=${some%.*}
		echo -e "   $some"
	done
	echo "Total: $(ls $STORE_DIR | wc -l)"
	exit 1
fi
if [ $1 = 'clear' ]; then
	awww clear-cache 1> /dev/null
	echo "SWWW cache cleared"
	exit 0
fi
if [ -z $2 ]; then
	echo "No theme were specified";
	exit 1;
fi
selected="$(ls $STORE_DIR | grep $2)"
file=$STORE_DIR/$selected
if [ ! -f "$file" ]; then
	echo "There is no theme with this name";
	exit 1;
fi
if [ $1 = 'set' ]; then 
 	awww img $STORE_DIR/$selected --transition-pos center --transition-angle 60 --transition-type grow --transition-fps 120    
 	echo "Theme changed to ${selected}"
fi

