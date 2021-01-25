#!/usr/bin/env bash

hash pip 2>/dev/null || {
    echo >&2 "This script requires pip but it is not installed. Aborting.";
    exit 1;
}

pip install haros-plugin-pyflwor || exit 1
pip install haros-plugin-pbt-gen || exit 1

echo "Done."
