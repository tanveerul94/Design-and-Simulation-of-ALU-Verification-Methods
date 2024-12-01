class alu_driver extends uvm_driver#(alu_transaction);
  //Utility Macro
  `uvm_component_utils(alu_driver)

  //Virtual Interface for Interface extension
  virtual alu_if vif;

  //Constructor
  function new(string name, uvm_component parent);
	super.new(name, parent);
  endfunction: new

  //Build virtual interface
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);

    void'(uvm_resource_db#(virtual alu_if)::read_by_name(.scope("*"), .name("alu_if"), .val(vif)));
  endfunction: build_phase

  //Run driver
  task run_phase(uvm_phase phase);
	drive();
  endtask: run_phase
 
  //Get transaction from sequencer and drive interface
  virtual task drive();
	alu_transaction alu_tx;

	forever begin
      seq_item_port.get_next_item(alu_tx);

      @(vif.driver_cb);	  
      vif.DRIVER.driver_cb.a <= alu_tx.a;
      vif.DRIVER.driver_cb.b <= alu_tx.b;
      vif.DRIVER.driver_cb.s <= alu_tx.s;
      
      seq_item_port.item_done();
	  
	end
  endtask: drive
  
endclass:alu_driver