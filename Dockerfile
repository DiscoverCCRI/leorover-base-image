FROM ros:noetic
ENV ROS_DISTRO=noetic

RUN mkdir -p /files/

COPY . /files/

SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN sh -c 'echo "deb http://files.fictionlab.pl/repo $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
&& apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key B09817643168B68528DE78BDB070AF638C33109D 
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install vim python3 git wget ros-noetic-laser-geometry ros-noetic-ar-track-alvar ros-noetic-leo-examples
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
