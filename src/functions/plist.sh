#!/bin/bash

function plist::path::python() {
  local pythonBin

  pythonBin=$(which python3) || pythonBin="/usr/bin/python3"
  if [ ! -f "$pythonBin" ]; then
    return 1
  fi

  echo "$pythonBin"
  return 0
}

function plist::path::defaults() {
  local defaultsBin

  if [[ $OSTYPE == 'darwin'* ]]; then
    defaultsBin="/usr/bin/defaults"
    if [ -f "$defaultsBin" ]; then
      echo $defaultsBin
      return 0
    fi
  fi

  return 1
}

function plist::value() {
  local plist key defaultsBin pythonBin retval value

  plist="$1"
  key="${2}"
  retval=1
  value=""
  defaultsBin=$(plist::path::defaults)
  if [ -n "$defaultsBin" ]; then
    value=$($defaultsBin read "$plist" "$key" 2>/dev/null)
    retval=$?
  elif [ -n "$pythonBin" ]; then
    value=$("$pythonBin" -c "import plistlib; print(plistlib.load(open('$plist', 'rb'))['$key'])" 2>/dev/null)
    retval=$?
  fi

  echo "$value"
  return $retval
}
