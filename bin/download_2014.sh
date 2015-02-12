#!/bin/bash
cd $(dirname $0)/..
curl -s http://www2.assemblee-nationale.fr/static/budget/plf2014/reserve_parlementaire.csv > data/final/reserve-assemblee-2014.csv
