#!/usr/bin/env sh

# A small script to generate the hardware configuration file
# Dependencies: mktemp nixos-generate-config

if test "x-$1" == "x-"
then
    OUTPUT_FILE="$(mktemp /tmp/hardware-configuration-XXX.nix)"
else
    OUTPUT_FILE="$1"
    if test -e $OUTPUT_FILE
    then
	    echo "File $OUTPUT_FILE exists; aborting"
	    exit 2
    fi
    touch $OUTPUT_FILE
fi

if test -w $OUTPUT_FILE
then
    nixos-generate-config --show-hardware-config > $OUTPUT_FILE
else
    echo "File $OUTPUT_FILE is not writable; aborting"
    exit 1
fi

echo "--- Begin file listing $OUTPUT_FILE ---"
cat $OUTPUT_FILE
echo "--- End file listing $OUTPUT_FILE ---"
