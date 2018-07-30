#!/bin/bash
## package name:dgh
 # Note: All helper functions should start with prefix dgh_
## Helper Script for disabling GPUS in miners
## Provide functions and set global variables required for disabling GPUS in miners
 # DEPENDENCY:
 #    bash 4.2+
 #    grep
 #    echo
 #    test
 # ARGUMENTS:
 #    FILE:
 #        generic_helper.sh
 #    GLOBAL:
 #        DISABLED_GPUS - Space delimted numbers. E.g: DISABLED_GPUS="0 1 5 ..."
 #        NVOC - nvoc directory path
 # RETURN:
 #    GLOBAL:
 #        DISABLED_GPU_ARRAY - Will be set according to DISABLED_GPUS. The array index will be the disabled GPU #, value will be unix time when it's set
 #                          E.g: DISABLED_GPU_ARRAY[0]= unix date
 #                               DISABLED_GPU_ARRAY[1]= unix date
 #                               DISABLED_GPU_ARRAY[5]= unix date
 # MINER REFERENCE:
 #    Bminer        : -devices 0,1,2,3,4,5,6,7,8,...
 #    CCMINER       : --devices 0,1,2,3,4,5,6,7,8,...
 #    CLAYMORE      : -di 0123456789abcdefghi...
 #    DSTM          : --dev 0 1 2 3 4 5 6 7 8 ...
 #    ETHMINER      : --cuda_devices 0 1 2 3 4 5 6 7 8 ...
 #    EWBF          : --cuda_devices 0 1 2 3 4 5 6 7 8 ...
 #    Z_EWBF        : --cuda_devices 0 1 2 3 4 5 6 7 8 ...
 #

source ${NVOC}/helpers/generic_helper.sh

####################################     Private Functions Start    ##################################

## Check the disabled gpu settings and update global DISABLED_GPU_ARRAY accordingly
 # ARGUMENTS:
 #    GLOBAL:
 #        DISABLED_GPUS
 #        DISABLED_GPU_ARRAY
 # RETURNS:
 #    - n/a
 #    GLOBAL:
 #        DISABLED_GPU_ARRAY
 #    ENV:
 #        CUDA_DEVICE_ORDER=PCI_BUS_ID
function _dgh_main () {
  [[ -z "$DISABLED_GPUS" ]] && {
    echo "DISABLED_GPUS not set"
    return 1
  } || {
    # Export CUDA_DEVICE_ORDER env variables
    export CUDA_DEVICE_ORDER=PCI_BUS_ID
    # Array doesn't exists till it's assign value
    [[ ! -v DISABLED_GPU_ARRAY[@] ]] && {
      #echo "declare DISABLED_GPU_ARRAY"
      declare -ga DISABLED_GPU_ARRAY
      for i in $DISABLED_GPUS; do
        DISABLED_GPU_ARRAY[$i]=$(date +%s)
      done
    }
    return 0
  }
}

####################################      Private Functions End     ##################################


####################################     Public Functions Start     ##################################

## Convert int to aphanumeric
 # ARGUMENTS:
 #    $1 int  - int to be converted, valid range 0-35
 # RETURNS:
 #    - The converted chr, [0-9a-z]
 #      10 => a, 11 => b... 35 => z
 #    STATUS:
 #        0   - success
 #        127 - error out of range
function dgh_int_to_alphanumeric () {
  local ascii_a_value=97
  # error 127 if non numeric
  gh_is_numeric $1 || return 127
  # Int too small return code 127
  [[ $1 -gt 35 || $1 -lt 0 ]] && return 127
  # Less than 10
  [[ $1 -lt 10 ]] && {
    echo $1 
    return 0
  }
  # within ascii range
  echo $(gh_chr $(( $1 -10 + ascii_a_value )))
}

## Convert alphanumeric to int
 # ARGUMENTS:
 #    $1 chr  - GPU # to be checked valid chr [0-9a-z]
 # RETURNS:
 #    - The converted int, 0-35
 #      a => 10, b => 11 ... 35 => z
 #    STATUS:
 #        0   - success
 #        127 - error out of range
function dgh_alphanumeric_to_int () {
  local ascii_a_value=97
  # Out of range
  [[ "$1" =~ ^[a-z0-9]$ ]] || return 127
  # numeric
  gh_is_numeric $1 && {
    echo $1
    return 0
  }
  # within ascii range
  echo $(( $(gh_ord $1) - ascii_a_value + 10 ))
}

## Check if GPU is disabled
 # ARGUMENTS:
 #    $1 alphanumeric - GPU # to be checked, [0-9a-z]
 #    GLOBAL:
 #        DISABLED_GPU_ARRAY
 # RETURNS:
 #    - n/a
 #    STATUS:
 #        0  - GPU is disabled
 #        1  - GPU is enabled
 #        127 - Error - Invalid Arg
 # NOTES:
 #    - Only single character alphabet is supported, a=10, b=11 ... and so on
 #      X Double char alphabet NOT supported, e.g. aa,bb
 #      X Alphabet mixing wih numeric NOT supported e.g. 1a, 0b
function dgh_is_gpu_disabled () {
  local gpu=$1
  # numeric
  if gh_is_numeric $gpu ; then
    [ ${DISABLED_GPU_ARRAY[$gpu]} ] && return 0 || return 1
  fi
  gpu=$(dgh_alphanumeric_to_int $gpu)
  [ -z $gpu ] && return 127
  [ ${DISABLED_GPU_ARRAY[$gpu]} ]
}

## Retrieve GPU counts
 # DEPENDENCY:
 #    nvidia-smi
 # ARGUMENTS:
 #    GLOBAL:
 #        GPUS
 # RETURNS:
 #    - Total number of gpu detected from $GPUS or nvidia-smi, return 0 if error
 #    STATUS:
 #        0 - success
 #        1 - error
function dgh_gpu_count () {
  local gpus=${GPUS:-$(nvidia-smi -i 0 --query-gpu=count --format=csv,noheader,nounits 2> /dev/null) }
  [ -z $gpus ] && {
    echo 0
    return 1
  }
  echo $gpus
}

## Update the input devices and removes the disabled gpus
 # ARGUMENTS:
 #    $1 str  - The device options's prefix, if there's a space between options and the GPU#, space should be included in this argument
 #                   E.g. ETHMINER OPTS is --cuda_devices 0 1 2 3, then pass '--cuda_devices ' as the arguments with trailing space
 #    $2 char - The delimiter between the GPU numbers, if there's no delimiter, pass in ''
 #                   E.g. pass ' ' for this arguments with the ETHMINER OPTS Example from above
 #    $3 str  - The original ETHMINER OPTS
 #    GLOBAL:
 #        DISABLED_GPU_ARRAY
 # RETURNS:
 #    - Original $3 with updated devices, removing disabled gpus. If there isn't a match between $3 and $1 and $2, $3 will be returned unaltered
 #        E.g.Given GPU 0 is disabled
 #        echo $(dgh_update_device '--devices ' ' ' '--devices 0 1 2 3 5 6 --otheropts xyz')
 #        # '--devices 1 2 3 5 6 --otheropts xyz'
 #    STATUS:
 #        0 - success
 #        1 - error but will echo the original input argument
 # OTHERS:
 #    - Supports Claymore device options of 0123456789abcd....
function dgh_update_devices () {
  local prefix=$1
  local delimiter=$2
  local input=$3
  # do nothing and echo back the input if no disabled gpu defined
  [[ ! -v DISABLED_GPU_ARRAY[@] ]] && {
    echo $input
    return 1
  }
  # String manipulation to extract substring from $input
  # e.g. match: 0,a,00,a0, possible fix with better regex in the future
  # [0-9a-z][0-9]\? will match alphanumeric digits + and optional 2nd digit
  # echo "$match" will will match '-dev 0,9,a,z,00,0a,99,z9' ; given '-device ' as prefix and ',' as delimiter
  [[ -z $prefix ]] && {
    echo "$input"
    return 1
  } 
  local match=$(expr "$input" : ".*\($prefix\([0-9a-z][0-9]\?$delimiter\)*[0-9a-z][0-9]\?\)")
  declare -a devices
  [[ -z $delimiter ]] && {
    # without delimiter, we break every character into individual array position
    # ${match#$prefix} remove the prefix and left only the actual device # specified
    # the outer () is for array creation
    devices=($(echo ${match#$prefix} | grep -o "[0-9a-z]"))
  } || {
    # Doesn't matter what delimiter is,
    # we put each group of alphanumeric into individual array position
    devices=($(echo ${match#$prefix} | grep -o "[0-9a-z]\+"))
  }
  local enabled_devices=''
  for dev in ${devices[@]}; do
    # Check if device is disabled
    # append to enabled_devices if not disabled
    dgh_is_gpu_disabled $dev || enabled_devices+="$dev$delimiter"
  done
  # Strip extra delimiter at the end
  [[ ! -z $enabled_devices ]] && enabled_devices=${enabled_devices%$delimiter}
  # return the orignal devices minus the disabled ones
  echo ${input/$match/"$prefix$enabled_devices"}
}

## Get all enabled devices
 # ARGUMENTS:
 #  $1 str  - The device options's prefix, if there's a space between options and the GPU#, space should be included in this argument
 #            E.g. ETHMINER OPTS is --cuda_devices 0 1 2 3, then pass '--cuda_devices ' as the arguments with trailing space
 #  $2 char - The delimiter between the GPU numbers, default to no delimiter, if there's no delimiter, pass in ''
 #            E.g. pass ' ' for this arguments with the ETHMINER OPTS Example from above
 #  $3 char - 'n' or 'a',
 #            'n' - generate the devices options in numeric: 0,1,2,3,..,10,... (Suitable for most miner)
 #            'a' - generate the devices in alphanumeric: 0123...abc... ($2 must be set '' to void the delimiter)
 #  $4 int  - # of gpus, default to GLOBAL_VARIABLE GPUS or query via smi if not set
 #  GLOBAL:
 #      GPUS
 #      DISABLED_GPU_ARRAY
 # RETURNS:
 #    - all GPUS that has not been disabled with $1 as prefix and GPU# seperated by $2
 #      E.g.  Given GPU 0 is disabled, $GPUS is 11
 #            echo $(dgh_all_devices '-di ' '' 'c' 11)
 #            # '-di 123456789a'
 #    - Empty string if no gpu is found
 # OTHERS:
 #    - Supports Claymore device options of 0123456789abcd....
function dgh_all_enabled_devices () {
  local prefix=$1
  local delimiter=${2-' '}
  local type=${3:-'n'}
  local gpus=${4:-$(dgh_gpu_count)}
  # echo "prefix: '$prefix'"
  # echo "delimiter: '$delimiter'"
  # echo "type: '$type'"
  # echo "gpus: '$gpus'"
  local devices=''
  for (( i=0; i < $gpus; i++ )) ; do
    # do nothing if no disabled gpu defined
    dgh_is_gpu_disabled $i || {
      [[ $type = 'a' ]] && devices+=$(dgh_int_to_alphanumeric $i) || devices+=$i
      devices+=$delimiter
    }
  done
  [[ ! -z $devices ]] && devices=${devices%$delimiter}
  echo "$prefix$devices"
}

## Update the input devices and removes the disabled gpus
 # ARGUMENTS:
 #  $1 str  - The device options's prefix, if there's a space between options and the GPU#, space should be included in this argument
 #            E.g. ETHMINER OPTS is --cuda_devices 0 1 2 3, then pass '--cuda_devices ' as the arguments with trailing space
 #  $2 char - The delimiter between the GPU numbers, if there's no delimiter, pass in ''
 #            E.g. pass ' ' for this arguments with the ETHMINER OPTS Example from above
 #  $3 char - 'n' or 'a',
 #            'n' - generate the devices options in numeric: 0,1,2,3,..,10,... (Suitable for most miner)
 #            'a' - generate the devices in alphanumeric: 0123...abc... ($2 must be set '' to void the delimiter)
 #  $4 str  - The original ETHMINER OPTS as input
 #  $5 int  - # of gpus, default to GLOBAL_VARIABLE GPUS or query via smi if not set
 #  GLOBAL:
 #      GPUS
 #      DISABLED_GPU_ARRAY
 # RETURNS:
 #    - all GPUS that has not been disabled with $1 as prefix and GPU# seperated by $2
 #    - $3 with updated devices, removing disabled gpus. If there isn't a match between $3 and $1, $3 will be returned unaltered
 #      E.g.  Given GPU 0 is disabled
 #            echo $(override_device_opts '--devices' ' ' '--devices 0 1 2 3 5 6 --otheropts xyz')
 #            # '--devices 1 2 3 5 6 --otheropts xyz'
 # OTHERS:
 #    - Supports Claymore device options of 0123456789abcd....
function dgh_enabled_devices () {
  local deli=${2-' '}
  # missing input
  [[ -z $4 ]] && {
    dgh_all_enabled_devices "$1" "$deli" "$3" "$5" && return 0
  }
  # input contain matching prefix
  [[ $4 =~ $1 ]] && {
    dgh_update_devices "$1" "$deli" "$4" 
  } || {
    # no matching prefix
    echo "$4 $(dgh_all_enabled_devices "$1" "$deli" "$3" "$5")"
  }
}
# COIN_${!MINER}_OPTS E.g. ZEC_BMINER_OPTS
# ALGO_${!MINER}_OPTS E.g. EQUIHASH_BMINER_OPTS
# MINER_OPTS    E.g. BMINER_OPTS
function dgh_get_miner_opts () {
  local coin=$1 algo=$2
  local xopts='_OPTS'
  local xminer='_MINER'
  local miner opts
#  echo "coin '$coin'"
#  echo "algo '$algo'"
  # Step 1. look for which miner is used
  [[ -z $coin && -z $algo ]] && { 
    echo ''
    return 1
  } 
  # look for where miner is assigned
  # First we look for $coin$xminer e.g. ZEC_MINER
  miner=${coin}${xminer}
#  echo "coin miner '$miner' val:'${!miner}'"
  # If nothing is found, we look for $algo$xminer e.g. EQUIHASH_MINER
  [[ -z ${!miner} ]] && {
    miner=${algo}${xminer}
#    echo "algo miner '$miner' val:'${!miner}'"
    # Error out if no miner defined
    [ -z ${!miner} ] && return 1
  }
  # Step 2. Look for where the OPTS is defined for this miner
  # For example we will pretend $miner='BMINER'
  # First look at $coin_$miner_OPTS. E.g. ZEC_BMINER_OPTS
  opts="${coin}_${!miner}$xopts"
#  echo "coin miner opts '$opts' val:'${!opts}'"
  # Not found, look at $algo_$miner_OPTS. e.g. EQUIHASH_BMINER_OPTS 
  [[ -z ${!opts} ]] && {
    opts="${algo}_${!miner}${xopts}"
#    echo "algo miner opts '$opts' val:'${!opts}'"
  } || {
    # Found! Return the opts
    echo ${!opts}
    return 0
  }
  # Still not found, we try $miner_OPTS e.g. BMINER_OPTS
  [[ -z ${!opts} ]] && {
    opts="${!miner}${xopts}" 
#    echo "miner opts '$opts' val:'${!opts}'"
  } || { 
    # Found! Return the opts
    echo ${!opts}
    return 0
  }
  # Still nothing 
  [[ -z ${!opts} ]] && { 
    # Found! Return the opts
    echo ""
    return 1 
  } || { 
    # found! return opts
    echo ${!opts}
    return 0
  }
}

####################################      Public Functions End      ##################################

######################################################################################################
##################################      Script Execution Start      ##################################
######################################################################################################

_dgh_main

