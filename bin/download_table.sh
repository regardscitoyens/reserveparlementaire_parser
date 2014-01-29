#!/bin/bash

for (( i = 0 ; i < 110 ; i++ )) do
   nb=$(expr $i '*' 100)
   wget -O data/tableau/$(printf '%06d' $nb).table "http://www2.assemblee-nationale.fr/reserve_parlementaire/plf/(offset)/$nb/(Legislature)/14/(Budget)/2013/(typeTri)/dest"
done
