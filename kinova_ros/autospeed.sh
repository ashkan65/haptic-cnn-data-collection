#!/bin/bash

echo "Please type in forward speed:"
read forward
echo "Please type in backward speed (must be negative to previous speed input):"
read backward
echo "Please type in repetition times:"
read times

for ((i=1;i<=$times;i++))
do
    timeout 2s rostopic pub -r 100 /j2n6s300_driver/in/cartesian_velocity kinova_msgs/PoseVelocity "{twist_linear_x: 0.0, twist_linear_y: 0.0, twist_linear_z: 1.0, twist_angular_x: 0, twist_angular_y: 0.0, twist_angular_z: 0.0}"

    rosservice call /'j2n6s300_driver'/in/stop

    rosservice call /'j2n6s300_driver'/in/start

    timeout 2s rostopic pub -r 100 /j2n6s300_driver/in/cartesian_velocity kinova_msgs/PoseVelocity "{twist_linear_x: 0.0, twist_linear_y: 0.0, twist_linear_z: -1.0, twist_angular_x: 0.0, twist_angular_y: 0.0, twist_angular_z: 0.0}"

    rosservice call /'j2n6s300_driver'/in/stop

    rosservice call /'j2n6s300_driver'/in/start

done

#Note the position to move towards desk: 
#  position: 
#    x: -0.3083969056606293
#    y: -0.00675916438922286
#    z: 0.2713705599308014
#  orientation: 
#    x: 0.03619980067014694
#    y: 0.9881238341331482
#    z: -0.097042977809906
#    w: -0.11350508034229279


