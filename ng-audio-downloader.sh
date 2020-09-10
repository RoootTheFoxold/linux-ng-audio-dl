#!/bin/bash
# Init
#  main
printf "\033c"

# Avoid errors
rm -r temp 2> /dev/null
#  Trap
sleep 0.1
trap 'echo -e "${LIGHTRED}An error occured! Check the song id and your internet connection!" && echo -e "${LIGHTRED}Exiting..." && sleep 4 && exit 1' ERR

#  Colors
NC='\033[0m'
RED='\033[0;31m'
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
# End Init

echo -e "${LIGHTCYAN}Please enter the Song ID:${NC}"
read songid
printf "\033c"
echo -e "${LIGHTCYAN}Please enter the Song ID:${NC}"
echo -e "${LIGHTCYAN}$songid"
echo -e "${WHITE}This song will be downloaded: $songid "
mkdir temp 2> /dev/null
dir=`pwd`
cd temp
echo -e "${WHITE}Fetching song information..."
wget -O song.temp https://rootrobo.ddns.net/newgrounds-api/details.php?url=https://www.newgrounds.com/audio/listen/$songid 2> /dev/null
echo -e "${LIGHTGREEN}Done!"
echo -e "${WHITE}Fetching download link... "
sleep 0.1
grep audio.ngfiles.com song.temp >song.temp.2 2> /dev/null
rm song.temp 2> /dev/null
sed 's/            "media": "//' song.temp.2 >song.temp.3
sleep 0.01
sed 's/.$//' song.temp.3 >song.temp.4
rm song.temp.2
rm song.temp.3
sed 's#\\##g' song.temp.4 >song.temp.dl
sleep 0.02
dl_link=`cat song.temp.dl`
echo -e "${LIGHTGREEN}Download link fetched successfully!"
sleep 0.2
echo -e "${WHITE}Deleting temporary files..."
cd $dir
rm -r temp 2> /dev/null
echo -e "${LIGHTGREEN}Temporary files have been deleted!"
echo -e "${WHITE}Downloading song..."
wget --noc-check-certificate $dl_link
sleep 2
echo -e "${LIGHTGREEN}Success! Song downloaded successfully!"
echo -e "${GREEN}Exiting... Goodbye!"
sleep 1
