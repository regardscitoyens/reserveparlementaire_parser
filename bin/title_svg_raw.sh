cat $1 | sed 's/\(<\/[^>]*>\)/\1\n/g' | sed 's/><text/>\n<text/' > svg
grep -v "<text" svg > bulles.svg
grep "<text " svg | while read line; do
  coords=$(echo $line | sed 's/^.*translate(//' | sed 's/)".*$//')
  text=$(echo $line | sed 's/^<text[^>]*>//' | sed 's/<\/text>.*//' | sed 's/, / /')
  sed 's/\('"$coords"')"[^>]*>\)/\1<title>'"$text"'<\/title>/' bulles.svg > bulles.new
  mv -f bulles.new bulles.svg
done
