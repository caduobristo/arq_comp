del work-obj93.cf
del toplevel_tb.ghw
ghdl -a reg16bits.vhd
ghdl -e reg16bits
ghdl -a ban_reg.vhd
ghdl -e ban_reg
ghdl -a rom.vhd
ghdl -e rom
ghdl -a state_machine.vhd
ghdl -e state_machine
ghdl -a control_unit.vhd
ghdl -e control_unit
ghdl -a ula.vhd
ghdl -e ula
ghdl -a program_counter.vhd
ghdl -e program_counter
ghdl -a toplevel.vhd
ghdl -e toplevel
ghdl -a toplevel_tb.vhd
ghdl -e toplevel_tb
ghdl -r toplevel_tb --wave=toplevel_tb.ghw
gtkwave toplevel_tb.ghw