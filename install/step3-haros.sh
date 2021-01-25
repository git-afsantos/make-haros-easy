#!/usr/bin/env bash

hash pip 2>/dev/null || {
    echo >&2 "This script requires pip but it is not installed. Aborting.";
    exit 1;
}

clang_version=$(ldconfig -p | grep libclang | grep -ohE "[[:digit:]]+\.[[:digit:]]+" | head -n 1)

if [ -z "$clang_version" ]
then
    echo >&2 "This script requires libclang but it is not installed. Aborting.";
    exit 1;
fi

if python -c 'import pkgutil; exit(not not pkgutil.find_loader("empy"))'; then
    pip install empy
fi

if python -c 'import pkgutil; exit(not not pkgutil.find_loader("defusedxml"))'; then
    pip install defusedxml
fi

pip install -Iv clang==$clang_version || exit 1
pip install lark-parser || exit 1
pip install haros || exit 1

echo "Done."
