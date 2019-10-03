.PHONY: with_default without_default

run: without_default with_default
	@echo "Running without default"
	without_default/Vverilator_case
	@echo
	@echo "Running with default"
	with_default/Vverilator_case

with_default: sim_main.cpp verilator_case.sv
	verilator -Wall -Wno-fatal --cc verilator_case.sv --exe sim_main.cpp --trace-fst --debug -DWITH_DEFAULT --Mdir with_default
	make -C with_default -f Vverilator_case.mk

without_default: sim_main.cpp verilator_case.sv
	verilator -Wall -Wno-fatal --cc verilator_case.sv --exe sim_main.cpp --trace-fst --debug --Mdir without_default
	make -C without_default -f Vverilator_case.mk

clean:
	rm -rf without_default with_default
