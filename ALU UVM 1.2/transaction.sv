class alu_transaction extends uvm_sequence_item;
  rand bit [7:0] a;
  rand bit [7:0] b;
  rand bit [3:0] s;
  bit [15:0] out;
  
  //Constructor
  function new(string name = "alu_transaction");
	super.new(name);
  endfunction: new

  //Utility and Field Macros
  `uvm_object_utils_begin(alu_transaction)
    `uvm_field_int(a,UVM_ALL_ON)
    `uvm_field_int(b,UVM_ALL_ON)
    `uvm_field_int(s,UVM_ALL_ON)
    `uvm_field_int(out,UVM_ALL_ON)
  `uvm_object_utils_end
  
endclass: alu_transaction