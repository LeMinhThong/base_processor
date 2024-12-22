onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sub_test/tb/cpu0/counter0/clock
add wave -noupdate /sub_test/tb/cpu0/cu/resetn
add wave -noupdate /sub_test/tb/cpu0/cu/run
add wave -noupdate /sub_test/tb/cpu0/din
add wave -noupdate /sub_test/tb/cpu0/cu/done
add wave -noupdate /sub_test/tb/cpu0/cu/ir_en
add wave -noupdate /sub_test/tb/cpu0/cu/ir
add wave -noupdate /sub_test/tb/cpu0/cu/clear
add wave -noupdate /sub_test/tb/cpu0/cu/state
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/cu/rout
add wave -noupdate /sub_test/tb/cpu0/cu/din_en
add wave -noupdate /sub_test/tb/cpu0/cu/gout
add wave -noupdate /sub_test/tb/cpu0/cu/ain
add wave -noupdate /sub_test/tb/cpu0/cu/gin
add wave -noupdate /sub_test/tb/cpu0/cu/sub
add wave -noupdate /sub_test/tb/cpu0/cu/rin
add wave -noupdate /sub_test/tb/cpu0/ir/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/mux/rout
add wave -noupdate /sub_test/tb/cpu0/mux/din_en
add wave -noupdate /sub_test/tb/cpu0/mux/gout
add wave -noupdate /sub_test/tb/cpu0/mux/din
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/mux/aluout
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/mux/buswires
add wave -noupdate /sub_test/tb/cpu0/alu0/ain
add wave -noupdate /sub_test/tb/cpu0/alu0/gin
add wave -noupdate /sub_test/tb/cpu0/alu0/sub
add wave -noupdate /sub_test/tb/cpu0/alu0/buswires
add wave -noupdate /sub_test/tb/cpu0/alu0/aluout
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r0/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r1/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r2/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r3/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r4/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r5/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r6/r
add wave -noupdate -radix hexadecimal /sub_test/tb/cpu0/r7/r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {422720 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 206
configure wave -valuecolwidth 108
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {493500 ps}
