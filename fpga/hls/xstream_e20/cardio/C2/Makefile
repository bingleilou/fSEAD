all:
	mkdir data
	cp ./../../../../data_hls/xstream/cardio_X data
	vivado_hls hls_prj.tcl -f
hls:
	mkdir data
	cp ./../../../../data_hls/xstream/cardio_X data
	vivado_hls hls_prj.tcl -f
clean:
	rm -rf *.log *.jou .Xil hls_xstream_*_prj/ hls_xstream_*_prj/ data/
    