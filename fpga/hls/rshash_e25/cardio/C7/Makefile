all:
	mkdir data
	cp ./../../../../data_hls/rshash/cardio_X data
	vivado_hls hls_prj.tcl -f
hls:
	mkdir data
	cp ./../../../../data_hls/rshash/cardio_X data
	vivado_hls hls_prj.tcl -f
clean:
	rm -rf *.log *.jou .Xil hls_rshash_*_prj/ vivado_rshash_*_prj/ data/
    