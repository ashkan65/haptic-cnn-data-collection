#!/bin/bash

echo "Please type in forward speed:"
read forward
echo "Please type in backward speed (must be negative to previous speed input):"
read backward
echo "Please type in repetition times:"
read times
for i in $times
do
    timeout 2s rostopic pub -r 100 /j2n6s300_driver/in/cartesian_velocity kinova_msgs/PoseVelocity "{twist_linear_x: 0.0, twist_linear_y: 0.0, twist_linear_z: $forward, twist_angular_x: 0.0, twist_angular_y: 0.0, twist_angular_z: 0.0}"

    rosservice call /'j2n6s300_driver'/in/stop

    rosservice call /'j2n6s300_driver'/in/start

    timeout 2s rostopic pub -r 100 /j2n6s300_driver/in/cartesian_velocity kinova_msgs/PoseVelocity "{twist_linear_x: 0.0, twist_linear_y: 0.0, twist_linear_z: $backward, twist_angular_x: 0.0, twist_angular_y: 0.0, twist_angular_z: 0.0}"

    rosservice call /'j2n6s300_driver'/in/stop

    rosservice call /'j2n6s300_driver'/in/start

done
