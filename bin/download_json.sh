#!/bin/bash

cd data/json
rm *json*
for (( i = 1 ; i < 11043 ; i++ )) do
   echo "http://www2.assemblee-nationale.fr/reserve_parlementaire/reserve_parlementaire_detail_json?beneficiaire=$i"
done > /tmp/json.url

wget -q -i /tmp/json.url

rm /tmp/json.url

cd -
