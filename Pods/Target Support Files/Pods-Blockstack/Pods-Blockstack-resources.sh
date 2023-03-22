#!/bin/sh
set -e
set -u
set -o pipefail

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
    # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
    # resou