`include "uvm_macros.svh" 
import uvm_pkg::*;
`include "interface.sv"
`include "sequencer.sv"
`include "monitor.sv"
`include "driver.sv"
`include "agent.sv"
`include "coverage.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv" 
`include "testcase01.sv"


module testbench;
  
  //#Run = #Test + 1(1st run is before taking inputs and consists only X values)
  int count = 101;
  
  //Clock
  bit clk;
  always #5 clk = ~clk;

  //Interface
  alu_if vif(clk);

  //DUT
  alu DUT (
    .a(vif.a),
    .b(vif.b),
    .s(vif.s),
    .out(vif.out),
    .clk(clk)
  );
  

  initial begin
	//Register Interface in configuration block
    uvm_resource_db#(virtual alu_if)::set(.scope("*"), .name("alu_if"), .val(vif));
    
    //Register #Run in configuration block
    uvm_config_db#(int)::set(uvm_root::get(), "*", "count", count);

	//Execute tests
    run_test("alu_testcase01");
  end
 
  initial begin
    $dumpfile("alu_uvm_dump.vcd");
    $dumpvars;
  end

endmodule