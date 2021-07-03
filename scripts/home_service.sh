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

echo launching rviz navigation with markers
xterm -e "source devel/setup.bash;
rosrun rviz rviz -d rvizConfig/navigation.rviz" &

sleep 10

echo publishing initial pose estimate
xterm -e "source devel/setup.sh;
cd scripts;
source publish_pose.sh" &

echo adding markers
xterm -e "source devel/setup.bash;
rosrun dynamic_reconfigure dynparam set /amcl update_min_d 0;
rosrun dynamic_reconfigure dynparam set /amcl update_min_a 0;
rosrun add_markers add_markers_node" &

sleep 3

echo sending pickup goals
xterm -e "source devel/setup.bash;
rosrun pick_objects pick_objects_node"