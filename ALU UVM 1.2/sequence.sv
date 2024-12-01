class alu_sequence extends uvm_sequence#(alu_transaction);
  //Utility Macro
  `uvm_object_utils(alu_sequence)
  
  //Set #Run
  int count;
  
  //Transaction class handle
  rand alu_transaction alu_tx;
  
  //Constructor
  function new(string name = "alu_sequence");
	super.new(name);
  endfunction: new

  //Create transaction, send transaction to driver for #Run of times
  task body();
    //Get the count value from testbench top
    if(!uvm_config_db#(int)::get(uvm_root::get(), "*", "count", count))
      `uvm_fatal("NOCOUNT", {"count must be set for: ", get_full_name(),".count"});
    
    alu_tx = alu_transaction::type_id::create(.name("alu_tx"), .contxt(get_full_name()));
    repeat(count) begin
      start_item(alu_tx);
      assert(this.randomize(alu_tx));
      finish_item(alu_tx);
	end
  endtask: body
  
endclass: alu_sequence