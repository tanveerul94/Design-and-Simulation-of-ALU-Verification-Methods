class addition_constraint extends alu_sequence;
  //Utility Macro
  `uvm_object_utils(addition_constraint)

  //Constructor
  function new(string name = "addition_constraint");
	super.new(name);
  endfunction: new
  
  //Declare constraints
    constraint inputs {
    alu_tx.a inside {[6:10]};
    alu_tx.b inside {[1:5]};
    alu_tx.s inside {[0:15]};
  }
  
endclass: addition_constraint


class alu_testcase01 extends alu_test;
  //Utility Macro
  `uvm_component_utils(alu_testcase01)

  //Constructor
  function new(string name = "alu_testcase01", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  //Start simulation with the set constraints
  function void start_of_simulation_phase(uvm_phase phase);
    set_type_override_by_type(alu_sequence::get_type(), addition_constraint::get_type());
  endfunction 
  
endclass : alu_testcase01