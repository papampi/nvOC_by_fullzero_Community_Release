#!/bin/bash
# package name:gh
# Generic Helper script
# Note: All helper functions should start with prefix gh_

####################################     Public Functions Start     ##################################

## Convert ASCII to character
 # ARGUMENTS:
 #    $1 int  - Value to be converted 0-255
 # RETURNS:
 #    - string representation of the ASCII
 #    STATUS:
 #        1 - error
gh_chr () {
  [ "$1" -lt 256 2>/dev/null ] && [ "$1" -ge 0 ] || return 1
  printf "\\$(printf '%03o' "$1")"
}

## Convert character to ASCII
 # ARGUMENTS:
 #    $1 char - Value to be converted
 # RETURNS:
 #    - Octal ASCII value of $1
 #    STATUS:
 #        1 - error
gh_ord () {
  [[ ${#1} -le 1 ]] || return 1
  printf '%d' "'$1"
}

## Test if input is gh_is_numeric
 # ARGUMENTS:
 #    $1 str  - Value to be tested
 # RETURNS:
 #    STATUS:
 #        0 - true
 #        1 - false
gh_is_numeric () {
  [ "$1" -eq "$1" 2> /dev/null ] || return 1
}
