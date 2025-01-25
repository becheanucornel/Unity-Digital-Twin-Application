# Digital Twin Application

This is part of my Virtual Reality term project.
I created a digital twin application for industrial applications.
It is intended to be used with a ABB IRC5 controller, either a 
virtual controller or a real controller, but it has been tested only 
with a virtual controller. 

## Unity 

In Unity I created a scene where I imported an ABB IRB1200 robot using
the URDF Importer provided by Unity Robotics Hub.
The robot in demo has a simple task of picking a cube that is moved by
a conveyour. 
Also I created some C# scripts that help the user move around the scene.
The conveyour has been imported from a github repository to make things simpler.
Here is the repository: https://github.com/goldennoodles/Remake-Belt-Conveyor-System/tree/main
Due to GitHub's file size limitation I had to compress the Unity Project.

As for robot movement, I overwritten the target propriety of the Articulation Bodies with
the values received from the robot controller.

## ABB RobotStudio

In RobotStudio I created a simple pick & place task which would make my robot move.
To send this values to Unity, I created a seperate continous task which uses TCP/IP
to send this data to Unity via a internet port.

## Demo

You can find the demo video in demo folder listed above.
Also I had to compress the file, due to GitHub's limit on file size.
If you intend to try this yourself, make sure you import the backup I added of the
ABB virtual controller and that you have apropriate firewall settings on your device.
Also as this approach uses TCP/IP for communication between the two apps, make sure you
first start the Unity Application between starting the program on the robot controller.