# Use the docker container to run HAROS

Install docker https://docs.docker.com/install/linux/docker-ce/ubuntu/

Build the HAROS docker image, for your desired ROS distro version:
```
cd path-to-make-haros-easy/docker
[sudo] docker build --tag=haros_ROS_DISTRO -f ROS_DISTRO/Dockerfile .
```

This repository supports currently the following ROS versions:
```
[sudo] docker build --tag=haros_melodic -f melodic/Dockerfile .
[sudo] docker build --tag=haros_noetic -f noetic/Dockerfile .
[sudo] docker build --tag=foxy_noetic -f foxy/Dockerfile .
```

Run the image with the docker extractor script givig as argument the url of the GitHub repository that holds the source code and mounting the `index.yaml` file to its filesystem:

Either
```
[sudo] docker run -it --mount type=bind,source=*Path to index.yaml*,target=/root/.haros/index.yaml -p 4000:4000 haros_ROS_DISTRO:latest /haros_call.sh *Repo URL*
```

or

```
[sudo] docker run -it -v *Path to index.yaml*:/root/.haros/index.yaml -p 4000:4000 haros_ROS_DISTRO:latest /haros_call.sh *Repo URL*
```

can be used.

### Examples

```
cd path-to-make-haros-easy/docker
[sudo] docker run -it --mount type=bind,source="$(pwd)"/index.yaml,target=/root/.haros/index.yaml -p 4000:4000 haros_noetic:latest /haros_call.sh https://github.com/ros/ros_tutorials
```

or

```
cd path-to-make-haros-easy/docker
[sudo] docker run -it -v "$(pwd)"/index_ros2.yaml:/root/.haros/index.yaml -p 4000:4000 haros_foxy:latest /haros_call.sh https://github.com/ros2/examples -b foxy
```
Open on your browser the page: http://localhost:4000/

