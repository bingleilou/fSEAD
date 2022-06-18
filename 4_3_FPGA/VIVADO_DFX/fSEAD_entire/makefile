overlay_name := system
design_name := system

all: static dynamic bitstream
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

static:
	vivado -mode batch -source $(overlay_name).tcl -notrace
	vivado -mode batch -source create_design.tcl -notrace

dynamic:
	vivado -mode batch -source create_pr.tcl -notrace

bitstream:
	vivado -mode batch -source build_bitstream.tcl -notrace

clean:
	rm -rf $(overlay_name) *.jou *.log NA
