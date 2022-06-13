FROM ros:noetic
ENV ROS_DISTRO=noetic

RUN mkdir -p /files/

COPY . /files/

SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN cd /root/ && mkdir catkin_ws && cd catkin_ws && mkdir src && cd src && catkin_create_pkg ros_test rospy roscpp std_msgs
RUN . /opt/ros/$ROS_DISTRO/setup.bash && cd ~/catkin_ws && catkin_make
COPY scripts /root/catkin_ws/src/ros_test/scripts
RUN cd /root/catkin_ws/src/ros_test/scripts && chmod +x *
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install vim
RUN apt-get -y install python3
