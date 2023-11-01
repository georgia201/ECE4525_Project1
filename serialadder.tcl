restart
add_force clk {0 0ns} {1 10ns}
add_force zero {0 0ns}

run 100ns

add_force A {00000010 0ns}
add_force B {00000001 0ns}

run 20ns

add_force A {00000001 0ns}
add_force B {00000001 0ns}

run 100ns