#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd `dirname $0` && pwd)
TOP_DIR=$(dirname ${SCRIPT_DIR})

ZONE_DIR="$TOP_DIR/zones"
DRYRUN="true"

if [[ $DOIT = "true" ]]; then
  DRYRUN="--doit"
fi

if [[ $VERSION = "external" ]]; then
  echo "external pushes are not currentl supported. ignoring doit."
  DRYRUN=""
fi

# creating export dir
mkdir -p exports

octodns-sync --config-file "$ZONE_DIR/$VERSION.yaml" $DRYRUN >/dev/null 2>&1