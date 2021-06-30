#!/bin/sh

echo launching turtlebot in HolidayCondo
xterm -e "source devel/setup.bash;
export ROBOT_INITIAL_POSE='-x -1.2 -y -3.0 -z -0.1 -R 0 -P 0 -Y 0';
roslaunch turtlebot_gazebo turtlebot_world.launch  world_file:=$(rospack find my_robot)/worlds/HolidayCondo.world" & 

sleep 10

echo launching amcl demo
xterm -e "source devel/setup.bash;
roslaunch turtlebot_gazebo amcl_demo.launch map_file:=$(rospack find my_robot)/maps/map.yaml" &

sleep 5

echo launching rviz view_navigation;
xterm -e "source devel/setup.bash;
roslaunch turtlebot_rviz_launchers view_navigation.launch" &

sleep 10

echo publishing initial pose estimate
xterm -e "source devel/setup.sh;
cd scripts;
source publish_pose.sh;
"

echo sending pickup goals
xterm -e "source devel/setup.bash;
rosrun pick_objects pick_objects_node;
"

