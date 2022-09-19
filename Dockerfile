FROM ros:noetic-perception-focal
ENV ROS_DISTRO=noetic
ENV ROVER

RUN mkdir -p /files/

COPY . /files/

SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install vim python3 git wget ros-noetic-laser-geometry
RUN mkdir -p ~/catkin_ws/src
RUN cd ~/catkin_ws/src && git clone https://github.com/DiscoverCCRI/RoverAPI.git \
&& mv ~/catkin_ws/src/RoverAPI/rover_api ~/catkin_ws/src \
&& mv ~/catkin_ws/src/RoverAPI/scripts/example.py ~/ \
&& chmod u+x ~/example.py \
&& rm -r ~/catkin_ws/src/RoverAPI
RUN cd ~/ && wget https://bootstrap.pypa.io/get-pip.py \
&& python3 get-pip.py && rm get-pip.py
RUN python3 -m pip install --upgrade pip && pip install opencv-python numpy matplotlib
RUN sudo apt-get install -y ros-noetic-cv-bridge
RUN . /opt/ros/$ROS_DISTRO/setup.bash && cd ~/catkin_ws && catkin_make
RUN cd ~/ && git clone https://github.com/DiscoverCCRI/RoverDemo.git && ./RoverDemo/manifest
RUN mkdir /experiment
RUN echo "echo \"${ROS_MASTER_URI:7:10} $ROVER\" >> /etc/hosts" >> /root/.bashrc
