# LeoRover Test Image
First, we need to build the container image by changing into the folder of the cloned repository and running the command:

```
docker build --network=host -t cjb873/leorover_image:1.0 .
```

Optionally, you can get the image from docker hub using the following command: 

```
docker pull cjb873/leorover_image:1.0
```

Then use docker-compose to run with the command:

```
docker compose -f docker-compose.yaml up -d
```

We will need to configue the LeoRover to be able to accept ROS messages from our docker container. You will need to get the IP address created by docker for the bridged network between your machine and your containers. To get the IP address use the command:

```
ifconfig
```

There you should see a connection starting with br followed by a list of random letters and numbers. For example:

```
br-e7058db0822d: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.18.0.1  netmask 255.255.0.0  broadcast 172.18.255.255
        ether 02:42:2b:cf:e6:94  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
 ```

From here you will need to add your container to your hosts file as the root user. You will add this IP address with a 2 for the last digit instead of a 1, followed by a space and the name of the container, which for this project is client. This should look like:

```
sudo echo "172.18.0.2 client" >> /etc/hosts
```

Now, you can use the following command to gain access to the container:
```
docker exec -it client /bin/bash
```
From here you should be able to see all of the rosnodes running on the rover and all of the rostopics published from those nodes. Additionally, you should be able to publish to new or previously existing rostopics from the container. You can test this with the following command:
```
rostopic pub /cmd_vel geometry_msgs/Twist "linear:
  x: .3048
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.0"
```
If the rover moves, everything should be working correctly. If you want to use multiple Docker containers on the rover, you will need to add the specific IP address of each container's bridged network to the hosts file.
