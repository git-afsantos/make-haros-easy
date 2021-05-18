# Use an official Python runtime as a parent image
FROM ros:noetic

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt upgrade -y && apt-get install -y \
    cppcheck \
    cccc \
    clang-10 \
    git \
    libclang-10-dev \
    python3-pip \
    llvm-10-dev \
    wget \
    netbase \
    libmagic-dev

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/lib/llvm-10/lib

RUN pip3 install --upgrade pip
RUN pip3 install -Iv clang==10.0.1
RUN pip3 install -e git+https://github.com/timtadh/pyflwor.git#egg=pyflwor
RUN pip3 install -e git+https://github.com/git-afsantos/haros.git@dev-py3-support#egg=haros
RUN pip3 install bonsai-code

RUN apt-get update && apt-get install -y ros-$ROS_DISTRO-desktop && apt upgrade -y

SHELL ["bash", "-c"]

RUN mkdir -p /root/ws/src

# Set the working directory
WORKDIR .

ENV CMAKE_CXX_COMPILER /usr/lib/llvm-10/bin/clang++

RUN source /opt/ros/$ROS_DISTRO/setup.bash;\
 cd /root/ws/src;\
 catkin_init_workspace;\
 cd /root/ws;\
 catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=1;\
 source /root/ws/devel/setup.bash; \
 haros init

COPY haros_call.sh /

EXPOSE 4000

CMD []
