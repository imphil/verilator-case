#include "Vverilator_case.h"
#include "verilated.h"
#include "verilated_fst_c.h"

int main(int argc, char** argv, char** env) {
  Vverilator_case* top = new Vverilator_case;

  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(true);
  VerilatedFstC* tfp = new VerilatedFstC;
  top->trace(tfp, 99);  // Trace 99 levels of hierarchy
  tfp->open("sim.fst");

  int main_time = 0;
  while (!Verilated::gotFinish()) {
    top->eval();
    top->clk_i = !top->clk_i;
    tfp->dump(main_time);
    main_time++;
  }
  delete top;
  exit(0);
}
