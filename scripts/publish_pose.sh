#!/bin/sh
rostopic pub -1 /initialpose geometry_msgs/PoseWithCovarianceStamped -f initial_pose.yaml
