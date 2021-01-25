#!/usr/bin/env bash

hash virtualenv 2>/dev/null || {
    echo >&2 "This script requires virtualenv but it is not installed. Aborting.";
    exit 1;
}

# get the directory this script is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# get the target directory to create a virtualenv
# or use the root of the repository if undefined
VENV_DIR=${1:-$DIR/..}
VENV_DIR="$(cd $VENV_DIR && pwd)"

echo "This script will create a Python virtual environment at:"
echo $VENV_DIR

cd $VENV_DIR

virtualenv harosenv || {
    echo >&2 "Failed to create virtual environment. Aborting.";
    exit 1;
}

cd harosenv

mkdir src
mkdir haroshome

echo "Done."
