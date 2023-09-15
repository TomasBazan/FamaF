transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/tomas/quartusProjects/Practico1 {/home/tomas/quartusProjects/Practico1/sl2.sv}
vlog -sv -work work +incdir+/home/tomas/quartusProjects/Practico1 {/home/tomas/quartusProjects/Practico1/mux2.sv}
vlog -sv -work work +incdir+/home/tomas/quartusProjects/Practico1 {/home/tomas/quartusProjects/Practico1/adder.sv}
vlog -sv -work work +incdir+/home/tomas/quartusProjects/Practico1 {/home/tomas/quartusProjects/Practico1/alu.sv}
vlog -sv -work work +incdir+/home/tomas/quartusProjects/Practico1 {/home/tomas/quartusProjects/Practico1/execute.sv}

vlog -sv -work work +incdir+/home/tomas/quartusProjects/Practico1 {/home/tomas/quartusProjects/Practico1/execute_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  execute_tb

add wave *
view structure
view signals
run -all
