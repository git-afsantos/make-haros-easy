#/bin/bash
cd /root/ws/src/
git clone $1

echo "## Install ROS pkgs dependencies and build ##"
cd /root/ws
if [ -n $ROS_VERSION ]
then
  if [ $ROS_VERSION == "1" ]
  then
    source devel/setup.bash
    rosdep install -y -i -r --from-path src
    catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  elif [ $ROS_VERSION == "2" ]
  then
    source install/setup.bash
    rosdep install -y -i -r --from-path src
    colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  else
    echo "ROS version not supported"
    exit
  fi
else
  echo "ROS installation not found"
fi


echo "## Init HAROS ##"
haros init

echo "## Call HAROS full analysis ##"
haros full --server-host 0.0.0.0:4000
