class alu_coverage extends uvm_subscriber#(alu_transaction);
  //Utility Macro
  `uvm_component_utils(alu_coverage)

  //Transaction class handle
  alu_transaction  alu_tx_cg;

  //Covergroup
  covergroup alu_cg;
    option.per_instance = 1;
    selector: coverpoint alu_tx_cg.s {
      bins addition         = {0};
      bins subtraction      = {1};
      bins multiplication   = {2};
      bins division         = {3};
      bins modulo_division  = {4};
      bins logical_and      = {5};
      bins logical_or       = {6};
      bins logical_negation = {7};
      bins bitwise_negation = {8};
      bins bitwise_and      = {9};
      bins bitwise_or       = {10};
      bins bitwise_xor      = {11};
      bins left_shift       = {12};
      bins right_shift      = {13};
      bins increment        = {14};
      bins decrement        = {15};
      option.at_least = 1;
    }
    op_a: coverpoint alu_tx_cg.a {
      bins zero_to_255 = {[0:255]};
    }
    cross_a_s: cross op_a,selector;
  endgroup: alu_cg

  //Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    alu_cg = new();
  endfunction: new

  //Write functional coverage #matches
  function void write(alu_transaction t);
    alu_tx_cg = t;
    alu_cg.sample();
  endfunction:write

endclass : alu_coverage