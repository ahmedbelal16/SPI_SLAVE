vlib work
vlog Ram.v Spi.v TOP_Module.v TOP_Module_tb.v
vsim -voptargs=+acc work.TOP_Module_tb
add wave *
run -all
#quit -sim

