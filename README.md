# Real-time-traffic-light-control-matlab


As the problem of urban traffic congestion spreads, there is a great need for the introduction of 
advanced technology and equipment to improve the state-of-the-art of traffic control. 
Traffic problems nowadays are increasing because of the growing number of vehicles and
the limited resources provided by current infrastructures. 

The simplest way for controlling a traffic light uses timer for each phase. 
Another way is to use electronic sensors in order to detect vehicles, and produce signal that cycles. 
These existing systems does not work with priority considering the density of traffic and also makes 
us wait even if there is no traffic on the other side of the road.  

The proposed system works by controlling the traffic light using image processing. 
The system will detect vehicles through images instead of using electronic sensors embedded in the pavement.
A camera will be installed alongside the traffic light. It will capture image sequences and are 
cropped to required areas. The resulting image sequence will  then  be processed using Guassian Mixture models 
in Matlab which performs foreground detection of the image. The number of vehicles are counted and the density 
of traffic is analysed through this method. According to traffic conditions on the road, traffic light can be controlled. 
The proposed system is to be implemented in matlab environment integrated with an arduino microcontroller 
which is connected through the USB port of a PC and produces the required traffic signal outputs.
