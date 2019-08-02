#!/bin/bash
echo "Copying fonts"

#check root library
echo "Checking for Fonts in Library"

if [[ -d "/Library/Fonts/" ]]; then
	echo "Fonts found"
	echo "Copying Fonts to USB"
	cp /Library/Fonts/* ./
else
	echo "Fonts not found in library"
fi

# Check for system fonts
echo "Checking for System Fonts"

if [[ -d "/System/Library/Fonts/" ]]; then
	echo "System Fonts found"
	echo "Copying System Fonts to USB"
	cp /System/Library/Fonts/* ./
else
	echo "System Fonts not found"
fi

# Check for network fonts
echo "Checking for Network Fonts"

if [[ -d "/Network/Library/Fonts/" ]]; then
	echo "Network Fonts found"
	echo "Copying Network Fonts to USB"
	cp /Network/Library/Fonts/* ./
else
	echo "Network Fonts not found"
fi

# Check for fonts in Legacy location
echo "Checking for Legacy Fonts"

if [[ -d "/System\ Folder/Fonts/" ]]; then
	echo "Legacy Fonts found"
	echo "Copying Legacy Fonts to USB"
	cp /System\ Folder/Fonts/* ./
else
	echo "Legacy Fonts not found"
fi

# check for user fonts
echo "Checking user files for other fonts..."

USER_PATHS=/Users/*
for path in $USER_PATHS
do
	font_directory="$path/Library/Fonts/"
	if [[ -e "$font_directory" && "$(ls -A $font_directory)" ]]; then
		echo "More fonts found at $font_directory"
		echo "Copying..."
		cp "$font_directory*" ./
	fi
done

# organize the fonts

# first create folders as needed
for folder in "./Postscript" "./TrueType" "./OpenType"
do
	if [[ ! -e "$folder" ]]; then
		echo "Making $folder directory"
		mkdir "$folder"
	fi
done

# start moving fonts
echo "Moving Postscript fonts"
mv ./*.ps ./Postscript/

echo "Moving TrueType fonts"
mv ./*.ttf ./TrueType/
mv ./*.tte ./TrueType/
mv ./*.dfont ./TrueType/

echo "Moving OpenType fonts"
mv ./*.otf ./OpenType/
mv ./*.otc ./OpenType/
mv ./*.ttc ./OpenType/

echo "DONE!!!"
