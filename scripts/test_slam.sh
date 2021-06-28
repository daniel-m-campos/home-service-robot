#!/bin/sh

echo launching turtlebot in HolidayCondo;
xterm -e "source devel/setup.bash;
export ROBOT_INITIAL_POSE='-x -1.2 -y -3.0 -z -0.1 -R 0 -P 0 -Y 0';
roslaunch turtlebot_gazebo turtlebot_world.launch  world_file:=$(rospack find my_robot)/worlds/HolidayCondo.world" & 

sleep 5

xterm  -e  " roslaunch turtlebot_navigation gmapping_demo.launch" & 

sleep 5

xterm  -e " roslaunch turtlebot_rviz_launchers view_navigation.launch" & #https://knowledge.udacity.com/questions/282891

sleep 5

xterm -e " roslaunch turtlebot_teleop keyboard_teleop.launch"
