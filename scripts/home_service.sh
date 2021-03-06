#!/bin/sh

echo launching turtlebot in Holiday Condo
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
rosrun rviz rviz -d rviz_config/home_service.rviz" &
sleep 10

echo publishing initial pose estimate
(
cd scripts || exit
rostopic pub --once /initialpose geometry_msgs/PoseWithCovarianceStamped -f initial_pose.yaml
)

echo setting \\"amcl"\\update_min_\{a,d\} to zero
rosrun dynamic_reconfigure dynparam set /amcl update_min_d 0;
rosrun dynamic_reconfigure dynparam set /amcl update_min_a 0;

echo adding markers
xterm -e "source devel/setup.bash;
rosrun add_markers add_markers_node" &
sleep 10

echo sending pickup goals
xterm -e "source devel/setup.bash;
rosrun pick_objects pick_objects_node" &
