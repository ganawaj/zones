#!/usr/bin/env bash
set -e

echo "::group::Generating zones"

SCRIPT_DIR=$(cd `dirname $0` && pwd)
echo "::debug::SCRIPT_DIR is $SCRIPT_DIR"

TOP_DIR=$(dirname ${SCRIPT_DIR})
echo "::debug::TOP_DIR is $TOP_DIR"

ZONE_DIR="$TOP_DIR/zones"
echo "::debug::ZONE_DIR is $ZONE_DIR"

DRYRUN="true"

if [[ $DOIT = "true" ]]; then
  DRYRUN="--doit"
  echo "::warning::Push is activated and changes will be made."

fi

if [[ $VERSION = "external" ]]; then
  echo "::warning::External pushes are not currentl supported. ignoring doit."
  DRYRUN=""
elif [[ $VERSION = "internal" ]]; then
  echo "setting random CLOUDFLARE_TOKEN"
  export CLOUDFLARE_TOKEN="FFF"
else
  echo "::error::$VERSION is invalid."
fi

echo "Creating export directory"
mkdir -p $TOP_DIR/exports

octodns-sync --config-file "$ZONE_DIR/$VERSION.yaml" $DRYRUN >/dev/null 2>&1