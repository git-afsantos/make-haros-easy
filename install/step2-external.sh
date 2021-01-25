#!/usr/bin/env bash

echo "WARNING: you might require root access to run this script."

apt-get install libclang-dev || exit 1
apt-get install clang || exit 1
#apt-get install cppcheck || exit 1
#apt-get install cccc || exit 1
