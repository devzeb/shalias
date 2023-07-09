#!/bin/bash

# enable echo of each command
set -x

# search trough the arguments for the first argument that doesn't start with -
for arg; do
  # if $arg does not start with a dash
  if [[ "$arg" != -* ]]; then
    first_arg="$arg"
  else
    newargs+=("$arg")
  fi
done
set -- "${newargs[@]}" # overwrites the original positional params
newargs=()             # reset newargs

# if first_arg is empty, print error and exit with error code 1
if [ -z "$first_arg" ]; then
  echo "No file specified, exiting now." >&2 # print error message
  exit 1
fi

# search trough the arguments for the first argument --file
for arg; do
  if [[ $arg == '--file' ]]; then
    # replace --file with -type f
    newargs+=(-type f)
  else
    newargs+=("$arg")
  fi
done
set -- "${newargs[@]}" # overwrites the original positional params
newargs=()             # reset newargs

# find in current directory any filesystem node containing the first argument to this script
find . "$@" -name "*$first_arg*"
