#!/bin/bash
cd $(dirname $0)/..
year=$1
curl -sL https://www2.assemblee-nationale.fr/static/budget/plf$year/reserve_parlementaire.csv > data/final/reserve-assemblee-$year.csv
