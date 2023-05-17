# Builder

This repo contains several Bash scripts designed to ease the building scripts, apps, and packages related to macOS administration.

## semver

This script helps with the management of version numbers. Current version numbers can be taken from an application bundle or Git repo tag, then incremented according to the flags given.

## build-script

This script will take `source` lines from your script and inline the sourced files for easier distribution. Only `source` lines with an `#inline` comment at the end of the line are parsed.  

The script can also help with the management of version numbers in your script by replacing a placeholder, typically `##VERSION##` with the proper version number.  The `semver` script above is used to calculate the proper version number, based on the given flags.

## build-platypus

This script is essentially a wrapper for 