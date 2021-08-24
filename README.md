# Make HAROS Easy

This is a repository of scripts to make [HAROS](https://github.com/git-afsantos/haros) installation and setup easier.

## Using HAROS with Docker

See the [docker directory](https://github.com/git-afsantos/make-haros-easy/tree/main/docker).  
For a manual installation, keep reading.

## Installing HAROS

Under [install](./install) you will find step-by-step scripts to install HAROS.
These assume that you have a working ROS installation and some additional dependencies, such as `virtualenv` and `pip`.

### Step 1 (Optional) - Virtual Environment

We recommend installing (and using) HAROS in a Python [virtual environment](https://pypi.org/project/virtualenv/), but this is completely optional.

Running [step 1](./install/step1-virtualenv.sh) will create a virtual environment for you. It can be executed without arguments,

```bash
./step1-virtualenv.sh
```

In which case it will create a virtual environment at the root of this repository.
Alternatively, you can provide it a suitable location for the virtual environment.

```bash
./install/step1-virtualenv.sh /path/to/env/parent
```

### Step 2 - External Dependencies

Some features of HAROS, namely model extraction, require external dependencies, such as `libclang`.
Installing the front-end of `clang` is also useful, to ensure that your ROS code compiles with it.
[Step 2](./install/step2-external.sh) handles this for you.

```bash
./install/step2-external.sh
```

**Note:** This script may require root access to run `apt-get`.

### Step 3 - HAROS

[Step 3](./install/step3-haros.sh) will install HAROS itself, along with some useful dependencies.

**Note:** This step requires `libclang` to be installed.

#### Using a Virtual Environment

Make sure to activate the virtual environment before proceeding.

```bash
source /path/to/venv/bin/activate
./install/step3-haros.sh
```

#### Not Using a Virtual Environment

Simply run the script.
Depending on your environment, this may or may not require root access.

```bash
./install/step3-haros.sh
```

### Step 4 - HAROS Plug-ins

Once HAROS is available, you can run [step 4](./install/step4-plugins.sh) to install some useful plug-ins.

If you are using a virtual environment, make sure that it remains active.

```bash
./install/step4-plugins.sh
```

### Step 5 (Optional) - Catkin Workspace

[This step](./install/step5-workspace.sh) will create a catkin workspace and download [example ROS packages](https://github.com/git-afsantos/haros_tutorials) to try out HAROS.
It is entirely optional.
If you opt to run it, make sure that you have `clang++` available.

The script requires a path to the root of the workspace.
If you are using a virtual environment, its root would be a suitable location.

```bash
./install/step5-workspace.sh /path/to/harosenv
```

This script will create some convenience scripts in the target directory.

The `activate` script is meant to be `source`d, not executed.
It is a shortcut to activate your virtual environment and source the catkin `devel/setup.bash` of the workspace.

The `catkin_make.sh` is executable, and is a shortcut to run `catkin_make` in the workspace, passing flags to compile with `clang++` and to create helper files that HAROS needs for model extraction.

### Step 6 - Try HAROS

After running the previous scripts, HAROS and some of its plug-ins are fully installed and ready to be used.

If you cloned the [example ROS packages](https://github.com/git-afsantos/haros_tutorials), either manually or with the provided script, now is a good time to try out the scripts contained in that repository.
Just ensure that the virtual environment (if used) is active.
