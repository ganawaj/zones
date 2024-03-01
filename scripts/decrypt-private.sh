#!/usr/bin/env bash
set -e

echo "::group::Decrypting secrets"

SCRIPT_DIR=$(cd `dirname $0` && pwd)
echo "::debug::SCRIPT_DIR is $SCRIPT_DIR"

TOP_DIR=$(dirname ${SCRIPT_DIR})
echo "::debug::TOP_DIR is $TOP_DIR"

ZONE_DIR="$TOP_DIR/zones"
echo "::debug::ZONE_DIR is $ZONE_DIR"

SECRET_DIR="$TOP_DIR/zones/secret"
echo "::debug::setting SECRET_DIR to $SECRET_DIR"

# check if secrets exists
# if [[ ! -z `find $SECRET_DIR -name '*.yaml'` ]]; then
#   echo "No valid secrets to decrypt"
#   exit 0
# else
#   echo "Decrypting secrets"
# fi

# For each of our files in our encrypted config
for src_file in $(find $SECRET_DIR -name '*.yaml'); do

  src_filename="$(basename "$src_file")"

  # Determine target for our file
  dest_path="$(yq .path $src_file)"
  target_file="$ZONE_DIR/$dest_path$src_filename"

  echo "Decrypting $src_filename to $target_file"

  # decrypt and place in build dir
  sops -d --ignore-mac $src_file | yq .data > $target_file
done

echo "::endgroup::"
