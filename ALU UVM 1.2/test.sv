class alu_test extends uvm_test;
  //Utility Macro
  `uvm_component_utils(alu_test)

  //Component Instances
  alu_env env;

  //Constructor
  function new(string name, uvm_component parent);
	super.new(name, parent);
  endfunction: new

  //Build component instance
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = alu_env::type_id::create(.name("env"), .parent(this));
  endfunction: build_phase

  //Run sequence
  task run_phase(uvm_phase phase);
	alu_sequence seq;

	phase.raise_objection(.obj(this));
	  seq = alu_sequence::type_id::create(.name("seq"), .contxt(get_full_name())); 
      seq.start(env.agents[0].alu_seq);
	phase.drop_objection(.obj(this));
  endtask: run_phase
  
endclass: alu_test