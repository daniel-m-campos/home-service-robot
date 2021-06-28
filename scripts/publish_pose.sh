#!/bin/bash
rostopic pub -1 /initialpose geometry_msgs/PoseWithCovarianceStamped -f initial_pose.yaml
