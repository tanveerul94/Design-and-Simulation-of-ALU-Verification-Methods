class alu_env extends uvm_env;

  //Component Instances
  alu_agent       agents[];
  alu_scoreboard  scb;
  alu_coverage    cov;
  int             num_agents = 2;
  string          inst_name;

  //Utility and Field Macros
  `uvm_component_utils_begin(alu_env)
    `uvm_field_int(num_agents, UVM_ALL_ON)
  `uvm_component_utils_end
  
  //Constructor
  function new(string name, uvm_component parent);
  	super.new(name, parent);
  endfunction: new

  //Build component instances, agents for component instances
  virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
    if(num_agents == 0)
      `uvm_fatal("NONUM","'num_agents' must be set");
    agents = new[num_agents];
    for(int i=0; i < num_agents; i++) begin
      $sformat(inst_name, "agents[%d]", i);
      agents[i] = alu_agent::type_id::create(.name(inst_name), .parent(this));
    end
    scb	  = alu_scoreboard::type_id::create(.name("scb"), .parent(this));
    cov   = alu_coverage::type_id::create(.name("cov"), .parent(this));
  
    //Set agents ACTIVE/PASSIVE
    uvm_config_db#(int)::set(uvm_root::get(),"*.agents[0]","is_active", UVM_ACTIVE);
    uvm_config_db#(int)::set(uvm_root::get(),"*.agents[1]","is_active", UVM_PASSIVE);
  endfunction: build_phase

  //Connect component instances' exports with agents
  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
    agents[0].agent_ap.connect(scb.sb_export_before);
    agents[1].agent_ap.connect(scb.sb_export_after);
    agents[0].agent_ap.connect(cov.analysis_export);
  endfunction: connect_phase
  
endclass: alu_env