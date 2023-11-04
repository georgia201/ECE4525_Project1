## INPUTS 
set_property -dict { PACKAGE_PIN C17 IOSTANDARD LVCMOS33 } [get_ports { START }];   #JA[1] 
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports { RESET }];   #JA[2]
set_property -dict { PACKAGE_PIN E17 IOSTANDARD LVCMOS33 } [get_ports { Q71 }];     #JA[8]
set_property -dict { PACKAGE_PIN D17 IOSTANDARD LVCMOS33 } [get_ports { Q72 }];     #JA[7]
#set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { CLK }]; 
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK}]; 
set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { CLK }];  #JB[10] 
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {CLK}]; 
## OUTPUTS 
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { DONE }];    #LED0
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { OVF }];     #LED3
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { OP_LD }];   #LED1 
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { RES_LD }];  #LED2 
set_property -dict { PACKAGE_PIN D14 IOSTANDARD LVCMOS33 } [get_ports { SRC1[1] }]; #JB[1]
set_property -dict { PACKAGE_PIN F16 IOSTANDARD LVCMOS33 } [get_ports { SRC1[0] }]; #JB[2]
set_property -dict { PACKAGE_PIN E16 IOSTANDARD LVCMOS33 } [get_ports { SRC2[1] }]; #JB[7]
set_property -dict { PACKAGE_PIN F13 IOSTANDARD LVCMOS33 } [get_ports { SRC2[0] }]; #JB[8]
set_property -dict { PACKAGE_PIN G16 IOSTANDARD LVCMOS33 } [get_ports { OE1 }];     #JB[3]
set_property -dict { PACKAGE_PIN G13 IOSTANDARD LVCMOS33 } [get_ports { OE2 }];     #JB[9]
set_property -dict { PACKAGE_PIN H14 IOSTANDARD LVCMOS33 } [get_ports { DS0 }];     #JB[4]
