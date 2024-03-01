#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd `dirname $0` && pwd)
TOP_DIR=$(dirname ${SCRIPT_DIR})

EXPORT_DIR="$TOP_DIR/exports/"

rm -rf $EXPORT_DIR