#!/usr/bin/env python3

import rospy
from std_msgs.msg import Int64


def num_pub(number):
    rospy.init_node('number_publisher')
    rospy.loginfo('number_publisher has started!')
    pub = rospy.Publisher('/numbers', Int64, queue_size=10)

    rate = rospy.Rate(2)

    while not rospy.is_shutdown():
        msg = Int64()
        msg.data = number
        
        pub.publish(msg)
        rate.sleep()

if __name__=='__main__':
    num_pub(20)



