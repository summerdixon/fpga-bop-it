#Clock
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports masterclk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports masterclk]

#Switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {SWITCH}]


#7 Segment Display
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {seg[0]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {seg[1]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {seg[2]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {seg[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {seg[4]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {seg[5]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {seg[6]}]
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {an[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {an[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {an[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {an[3]}]


#7 Segment Display
set_property -dict { PACKAGE_PIN J3   IOSTANDARD LVCMOS33 } [get_ports {ext_seg[0]}]
set_property -dict { PACKAGE_PIN L3   IOSTANDARD LVCMOS33 } [get_ports {ext_seg[1]}]
set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports {ext_seg[2]}]
set_property -dict { PACKAGE_PIN N2   IOSTANDARD LVCMOS33 } [get_ports {ext_seg[3]}]
set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports {ext_seg[4]}]
set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports {ext_seg[5]}]
set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports {ext_seg[6]}]
set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports {ext_an}]


#Buttons
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports BUTTON]
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports JOYSTICK1]
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports JOYSTICK2]


#LEDs
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports LED_loss]
set_property -dict { PACKAGE_PIN L1   IOSTANDARD LVCMOS33 } [get_ports LED_bop]
set_property -dict { PACKAGE_PIN P1   IOSTANDARD LVCMOS33 } [get_ports LED_pull]
set_property -dict { PACKAGE_PIN N3   IOSTANDARD LVCMOS33 } [get_ports LED_turn]


# SPI Interface for PmodJSTK on JB Header
#Pmod Header JB
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports cs];#Sch name = JB1
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports mosi];#Sch name = JB2
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports miso];#Sch name = JB3
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports sclk];#Sch name = JB4
set_property PULLDOWN true [get_ports miso]
