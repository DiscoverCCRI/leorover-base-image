# LeoRover Test Image

First we will need to configue the LeoRover to be able to accept ROS messages from our docker container. You will need to get the IP address created by docker for the bridged network between your machine and your containers. To get the IP address use the command:

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

From here you will need to add your container to your hosts file as the root user. You will add this IP address with a 2 for the last digit instead of a 1, followed by a space and the name of the container, which for this project is clients. This should look like:

```
sudo echo "172.18.0.2 client" >> /etc/hosts
```

Now we can build the container image by changing into the folder of the cloned repository and running the command:

```
docker build -t ros_image:1.0 .
```

Then use docker-compose to run with the command:

```
docker-compose -f docker-compose.yaml up -d
```

The LeoRover should run a short driving program, and then stop.
