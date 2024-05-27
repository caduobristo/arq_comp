del work-obj93.cf
del processador_tb.ghw
ghdl -a reg16bits.vhd
ghdl -e reg16bits
ghdl -a ban_reg.vhd
ghdl -e ban_reg
ghdl -a rom.vhd
ghdl -e rom
ghdl -a state_machine.vhd
ghdl -e state_machine
ghdl -a adder.vhd
ghdl -e adder
ghdl -a control_unit.vhd
ghdl -e control_unit
ghdl -a ula.vhd
ghdl -e ula
ghdl -a program_counter.vhd
ghdl -e program_counter
ghdl -a processador.vhd
ghdl -e processador
ghdl -a processador_tb.vhd
ghdl -e processador_tb
ghdl -r processador_tb --wave=processador_tb.ghw
gtkwave processador_tb.ghw