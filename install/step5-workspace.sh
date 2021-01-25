#!/usr/bin/env bash

hash catkin_make 2>/dev/null || {
    echo >&2 "This script requires catkin_make but it is not installed. Aborting.";
    exit 1;
}

hash git 2>/dev/null || {
    echo >&2 "This script requires git but it is not installed. Aborting.";
    exit 1;
}

VENV_DIR=$1

if [ -z "$VENV_DIR" ]
then
    echo >&2 "This script requires a path to the workspace root. Aborting.";
    exit 1;
fi

VENV_DIR="$(cd $VENV_DIR && pwd)"

cd $VENV_DIR

if [ ! -d "$VENV_DIR/src" ]; then
    mkdir src
fi

cat > activate <<EOF
#!/usr/bin/env bash
source $VENV_DIR/bin/activate
source $VENV_DIR/devel/setup.bash

EOF

clang_version=$(dpkg -l | grep clang | grep -ohE "[[:digit:]]+\.[[:digit:]]+" | head -n 1)

if [ -z "$clang_version" ]
then
    echo >&2 "This script requires clang but it is not installed. Aborting.";
    exit 1;
fi

cd src

git clone https://github.com/git-afsantos/haros_tutorials.git || exit 1

cd ..

cat > catkin_make.sh <<EOF
#!/usr/bin/env bash
catkin_make --force-cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER=/usr/bin/clang++-$clang_version

EOF

chmod u+x catkin_make.sh || exit 1

./catkin_make.sh || exit 1

echo "Done."
