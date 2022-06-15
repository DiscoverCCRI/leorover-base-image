FROM ros:noetic
ENV ROS_DISTRO=noetic

RUN mkdir -p /files/

COPY . /files/

SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install vim python3 git
RUN mkdir -p ~/catkin_ws/src
RUN cd ~/catkin_ws/src && git clone https://github.com/DiscoverCCRI/RoverAPI.git \
&& mv ~/catkin_ws/src/RoverAPI/rover_api ~/catkin_ws/src \
&& mv ~/catkin_ws/src/RoverAPI/scripts/example.py ~/ \
&& chmod u+x ~/example.py \
&& rm -r ~/catkin_ws/src/RoverAPI
RUN . /opt/ros/$ROS_DISTRO/setup.bash && cd ~/catkin_ws && catkin_make

