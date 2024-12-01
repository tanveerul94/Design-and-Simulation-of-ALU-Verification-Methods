class alu_monitor extends uvm_monitor;
  //Utility Macro
  `uvm_component_utils(alu_monitor)

  //Analysis Port (broadcasts transactions)
  uvm_analysis_port#(alu_transaction) mon_ap;

  //Virtual Interface for Interface extension
  virtual alu_if vif;

  //Component Instance
  alu_transaction alu_tx;
	
  //Constructor
  function new(string name, uvm_component parent);
	  super.new(name, parent);
  endfunction: new

  //Build virtual interface, component instance
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);

    void'(uvm_resource_db#(virtual alu_if)::read_by_name(.scope("*"), .name("alu_if"), .val(vif)));
    mon_ap = new(.name("mon_ap"), .parent(this));
  endfunction: build_phase

  //Get transaction from monitor
  task run_phase(uvm_phase phase);
	alu_tx = alu_transaction::type_id::create (.name("alu_tx"), .contxt(get_full_name()));

	forever begin
      @(vif.mon_cb);
	    alu_tx.a   = vif.MONITOR.mon_cb.a;
	    alu_tx.b   = vif.MONITOR.mon_cb.b;
		alu_tx.s   = vif.MONITOR.mon_cb.s;
		alu_tx.out = vif.MONITOR.mon_cb.out;

      //Send the transaction to the analysis port
      mon_ap.write(alu_tx);			
	end
  endtask: run_phase

endclass: alu_monitor