transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Benjamin\ Betancourt/Desktop/Comp_Eng_Design_Lab_2/Activity_4 {C:/Users/Benjamin Betancourt/Desktop/Comp_Eng_Design_Lab_2/Activity_4/counter_with_features.v}
vlog -vlog01compat -work work +incdir+C:/Users/Benjamin\ Betancourt/Desktop/Comp_Eng_Design_Lab_2/Activity_4 {C:/Users/Benjamin Betancourt/Desktop/Comp_Eng_Design_Lab_2/Activity_4/hexSevenSegmentDecoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Benjamin\ Betancourt/Desktop/Comp_Eng_Design_Lab_2/Activity_4 {C:/Users/Benjamin Betancourt/Desktop/Comp_Eng_Design_Lab_2/Activity_4/clockDiv.v}

