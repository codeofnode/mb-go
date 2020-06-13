inotifywait -r -q -e close_write -m . |
while read -r directory events filename; do
  if [ "${filename##*.}" = "go" ]; then
    case "$1" in
      test)
        go test $directory -v --cover;;
      *)
        go $1 $directory
    esac
  fi
done
