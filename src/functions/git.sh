#!/bin/bash

function git::path() {
  local gitBin

  gitBin=$(which git) || gitBin="/usr/bin/git"

  [ ! -f "$gitBin" ] && return 1

  echo "$gitBin"
  return 0
}

function git::isRepo() {
  local gitBin inRepo

  if gitBin=$(git::path); then
    inRepo=$("$gitBin" rev-parse --is-inside-work-tree)
    [ "$inRepo" == "true" ] && return 0
  fi

  return 1
}

function git::version() {
  local gitBin version

  if gitBin=$(git::path); then
    version=$($gitBin describe --abbrev=0 2> /dev/null | sed 's/^v//')
    [ -n "$version" ] && echo "$version" && return 0
  fi

  return 1
}
