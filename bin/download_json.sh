#!/bin/bash

cd data/json
rm *json*
for (( i = 1 ; i < 11043 ; i++ )) do
  url="http://www2.assemblee-nationale.fr/reserve_parlementaire/reserve_parlementaire_detail_json?beneficiaire=$i"
  ct=0
  while [ $ct -lt 5 ] ; do
    curl -f -s -L "$url" > "$i.json"
    size=$(cat "$i.json" | wc -c)
    if [ $size -gt 10 ]; then
      break
    fi
    ct=$(($ct+1))
    if [ $ct -eq 5 ]; then
      if [ $size -ne 2 ]; then
        echo "FAILED to download data at $url"
      fi
    else
      sleep 1
    fi
  done
done

cd ../..
