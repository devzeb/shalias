#!/bin/bash

function call_untar() {
  # check if tar is installed
  if ! command -v tar &>/dev/null; then
    echo "tar is not installed, exiting now." >&2 # print error message
    exit 3
  fi

  if [ -z "$2" ]; then # check if second parameter is empty
    # call with all arguments
    tar -xvf "$1"
  else
    # untar it into the specified directory
    tar -xvf "$1" -C "$2"
  fi
}

function call_unzip() {
  # check if unzip is installed
  if ! command -v unzip &>/dev/null; then
    echo "unzip is not installed, exiting now." >&2 # print error message
    exit 3
  fi

  # check if second parameter is empty
  if [ -z "$2" ]; then
    unzip "$1" # unzip it into the current directory
  else
    unzip "$1" -d "$2" # unzip it into the specified directory
  fi
}

if [ -z "$1" ]; then                         # check if first parameter is empty
  echo "No file specified, exiting now." >&2 # print error message
  exit 1
fi

# check if file ends with .tar.<any extension>
if [[ "$1" =~ \.tar\.[a-zA-Z0-9]+$ ]]; then
  # call function untar with all arguments
  call_untar "$@"
# else if file ends with .zip
elif [[ "$1" =~ \.zip$ ]]; then
  call_unzip "$@"
else
  echo "File type not supported, exiting now." >&2 # print error message
  exit 2
fi
