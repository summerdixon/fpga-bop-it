# FPGA Bop It Game
This project was built as a part of my Digital Design Laboratory class. It was created using the Xilinx Vivado Design Suite and a Basys3 FPGA. 
## How It Works
The seven-segment display will flash a command and the player will have a fixed amount of time to perform the corresponding action on the FPGA (press a button, toggle a switch, or interact with an external joystick). As the player completes more actions, the time interval will decrease and if the player fails, a message displays on the seven-segment display and their score (which is kept track of the whole game on an external SSD) flashes.
