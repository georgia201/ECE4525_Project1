restart  
add_force CLK {0 0ns} {1 10ns} -repeat_every 20ns   

#Wait out 100ns GSR (important for post-route timing simulation, but not for behavioral simulations) 
add_force START {0 0ns}  
add_force RESET {0 0ns}  
add_force Q71 {0 0ns}  
add_force Q72 {0 0ns}
run 100ns 

add_force START {1 0ns}  
add_force RESET {1 0ns}  
add_force Q71 {0 0ns}  
add_force Q72 {0 0ns}
run 60ns

add_force Q71 {1 0ns}  
add_force Q72 {0 0ns}
run 20ns

add_force Q71 {0 0ns}  
add_force Q72 {1 0ns}
run 20ns

add_force Q71 {0 0ns}  
add_force Q72 {0 0ns}
run 160ns