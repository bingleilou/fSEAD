all:
	mkdir data
	cp ./../../../../data_hls/loda/cardio_X data
	vivado_hls hls_prj.tcl -f
hls:
	mkdir data
	cp ./../../../../data_hls/loda/cardio_X data
	vivado_hls hls_prj.tcl -f
clean:
	rm -rf *.log *.jou .Xil hls_loda_*_prj/ vivado_loda_*_prj/ data/
    