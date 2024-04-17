cd C:\Users\caduo\OneDrive\Documentos\Facul\arq_comp\vhdl\lab02\ULA
ghdl -a ULA.vhd
ghdl -e ULA
ghdl -a ULA_tb.vhd
ghdl -e ULA_tb
ghdl -r ULA_tb --wave=ULA_tb.ghw
gtkwave ULA_tb.ghw