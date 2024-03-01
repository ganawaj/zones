#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd `dirname $0` && pwd)
TOP_DIR=$(dirname ${SCRIPT_DIR})

SECRET_DIR="$TOP_DIR/zones/secret"

# For each of our files in our encrypted config
for src_file in $(find $SECRET_DIR -name '*.yaml'); do

  src_filename="$(basename "$src_file")"

  # Determine target for our file
  dest_path="$(yq .path $src_file)"
  target_file="$TOP_DIR/$dest_path$src_filename"

  # decrypt and place in build dir
  sops -d --ignore-mac $src_file | yq .data > $target_file

done