#!/usr/bin/env bash
set -e

ls
pwd

echo "::group::Decrypting secrets"

SCRIPT_DIR=$(cd `dirname $0` && pwd)
echo "SCRIPT_DIR is $SCRIPT_DIR"

TOP_DIR=$(dirname ${SCRIPT_DIR})
echo "TOP_DIR is $TOP_DIR"

ZONE_DIR="$TOP_DIR/zones/"
echo "ZONE_DIR is $ZONE_DIR"

SECRET_DIR="$TOP_DIR/zones/secret"
echo "setting SECRET_DIR to $SECRET_DIR"
echo "::endgroup::"

# check if secrets exists
if [[ ! -z `find $SECRET_DIR -name '*.yaml'` ]]; then
  echo "No valid secrets to decrypt"
  exit 0
else
  echo "Decrypting secrets"
fi

# For each of our files in our encrypted config
for src_file in $(find $SECRET_DIR -name '*.yaml'); do

  src_filename="$(basename "$src_file")"
  echo "::group::Decrypting $src_filename"

  # Determine target for our file
  dest_path="$(yq .path $src_file)"
  target_file="$ZONE_DIR/$dest_path$src_filename"

  echo "decrypting to $target_file"

  # decrypt and place in build dir
  sops -d --ignore-mac $src_file | yq .data > $target_file
echo "::endgroup::"
done
