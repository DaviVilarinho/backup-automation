#!/bin/zsh

for year in {2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024}
do 
  rclone copy google-photos:media/by-year/$year/ ~/data/media/others/$year/google-photos 
done
