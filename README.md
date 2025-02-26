# Humod_Torques

All codes presented here use data from https://www.sim.informatik.tu-darmstadt.de/res/ds/humod/ . However they can easily be adapted for other model or data

Codes present method and result to get the torques from a human biomechanical model of 30 degrees of freedom (DoF) + 6 DoF (virtual joint between the world and the pelvis). For more information please see Humod documents and the article:...

All torque obtained with Newton-Euler method and Simscape avalaible in NE_Torques and Simscape_Torques have been obtained for subject A.

To use these codes on matlab, add to path all the directorie to path.


# Newton-Euler
This method is available in the Newton-Euler directory, to use it on different motion, just put the Humod motion needed at the beginning in "Motion". 

If you want to use these codes with an other model, you wil need to express: 

   -Distance between two joints of a segment in the segment coordinate system.
   
   -Distance between the parent joint of a segment and the center of mass of the segment in the segment coordinate system.
   
   -Masses, Inertia of each segment.
   
   -The gravity vector
   
   -Movements parameter (joint position, velocities and accelerations).

There is two phases in the loop: Determine velocities and acceleration of each segment in the world coordinate system (from the root to the leaves) then applied the fundamental princple of dynamic (from the leaves to the root) applied in the world coordinate system at the origin. 
All values are expressed in the world coordinate systeme

During the first step, you need to express:

   -Rotation Matrix of Segments coordinate system to the world one.
   
   -Positions of joints in the world coordinates system using : the previous joints, the distance between joint and the previous rotation matrix.
   
   -The unit vector of the rotation.
   
   -Velocities and accelerations using: the previous ones, joints velocities and accelerations, postions of the parent joint and the unit vector of rotation.

During the second step, you need to express:

   -The position of the center of mass using : the parent joint, the distance between joint and center of mass and the previous rotation matrix.
   
   -The inertia matrix (of 6x6 dimension) using: segment mass and inertia and the position of the center of mass.
   
   -"Forces" du to acceleration effect using : the inertia matrix, acceleration and velocitie of the segment.
   
   -External forces on the segment expressed at the origin of the world.
   
   -Forces at the joint using the previous forces and the forces of the previous joint.

For this model ground reaction forces and weight forces have been used.

Then articulation torques are get from forces applying on the joint.


# Simscape
This method is available in the Simscape directory, to use it on different motion, just put the Humod motion needed at the beginning. 

The slx file correspond to the model of our biomechanical model. You can create your own model using the same process. "Solid" blocks correspond to segment and "Gimbal Joint" blocks to articulation, just add or remove these blocks as needed.
Additional solid blocks have been added for visual reason, but they can be replace by "Rigid Transform" blocks. On this model, one can notice 

Then, in Model_Torque.m, you need to set every blocks parameters to create your model. Then, you set all your motions under time series data as shown. 
For ground reaction forces, a cartesian joint is used to move the center of pressure under feet. You will need to determine before the value of these positions, conversion of vectors from the world coordinates system to feet ones has been done using litteral expression of rotational matrices obtained using the sym library of matlab.

# Computed ground reaction effort method
With the previous methods a virtual joint between the world and the body has been add. However efforts have been found on this virtual joint. To vanish them, we modify ground reaction forces:

-We first compute Newton-Euler without ground reaction forces

-We distribute these efforts found on the virtual joint on the two feet.

-We compute again Newton-Euler with these new ground reactions forces.

If you want to adapt codes to your model, you will have to simply applied the modification of Newton-Euler (twice).

Codes for the distribution of ground reaction forces has been inspired from https://github.com/wojtusch/HuMoD

/!\ these codes only work for walking and running.
