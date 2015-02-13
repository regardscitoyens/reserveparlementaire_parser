#!/bin/bash

cd ($dirname $0)

git pull > /dev/null

# 2013
#bash bin/generate.sh

# 2014
bash bin/download_2014.sh

if git diff data/final/reserve-assemblee-*.csv | grep "+" > /dev/null; then
  git commit data/final/reserve-assemblee-*.csv -m "update data"
  git push
fi

