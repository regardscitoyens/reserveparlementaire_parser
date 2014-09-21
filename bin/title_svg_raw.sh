grep -v "<text" svg > bulles
grep "<text " svg | while read line; do
  coords=$(echo $line | sed 's/^.*translate(//' | sed 's/)">.*$//')
  text=$(echo $line | sed 's/^.*)">//' | sed 's/<\/text>//')
  sed 's/\('"$coords"')"[^>]*>\)/\1<title>'"$text"'<\/title>/' bulles > bulles.new
  mv -f bulles{.new,}
done
