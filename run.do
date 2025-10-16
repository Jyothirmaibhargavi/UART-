vlib work
#compilation
vlog uart.v
vlog uart_tb.v
#elaboration
vsim -novopt -suppress 12110 uart_tb
#adding wave
add wave -position insertpoint sim:/uart_tb/*
#run
run -all
