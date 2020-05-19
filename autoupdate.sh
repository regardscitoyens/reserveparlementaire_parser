#!/bin/bash

cd $(dirname $0)

git pull > /dev/null

# 2013
#bash bin/generate.sh

# 2014+
for year in 14 15 16; do
  bash bin/download_year.sh "20$year"
done

if git diff data/final/reserve-assemblee-*.csv | grep "+" > /dev/null; then
  git commit data/final/reserve-assemblee-*.csv -m "update data"
  git push
fi

