class alu_agent extends uvm_agent;
  //Utility Macro
  `uvm_component_utils(alu_agent)

  //Analysis Port (broadcasts transactions)
  uvm_analysis_port#(alu_transaction) agent_ap;

  //Component Instances
  alu_sequencer		    alu_seq;
  alu_driver		    alu_drv;
  alu_monitor        	alu_mon;

  //Constructor
  function new(string name, uvm_component parent);
	super.new(name, parent);
  endfunction: new

  //Build component instances
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	agent_ap   = new(.name("agent_ap"), .parent(this));
    if(is_active == UVM_ACTIVE) begin
      alu_seq  = alu_sequencer::type_id::create(.name("alu_seq"), .parent(this));
      alu_drv  = alu_driver::type_id::create(.name("alu_drv"), .parent(this));
    end
    alu_mon  = alu_monitor::type_id::create(.name("alu_mon"), .parent(this));
  endfunction: build_phase

  //Connect component instances' ports/exports
  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);	
    if(is_active == UVM_ACTIVE) begin
      alu_drv.seq_item_port.connect(alu_seq.seq_item_export);
    end
	alu_mon.mon_ap.connect(agent_ap);
  endfunction: connect_phase
  
endclass: alu_agent