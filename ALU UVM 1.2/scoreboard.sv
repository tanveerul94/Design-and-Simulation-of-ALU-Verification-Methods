class alu_scoreboard extends uvm_scoreboard;
  //Utility Macro
  `uvm_component_utils(alu_scoreboard)

  //Analysis Port (broadcasts transactions)
  uvm_analysis_export #(alu_transaction) sb_export_before;
  uvm_analysis_export #(alu_transaction) sb_export_after;

  //Analysis FIFO (gets transactions)
  uvm_tlm_analysis_fifo #(alu_transaction) before_fifo;
  uvm_tlm_analysis_fifo #(alu_transaction) after_fifo;

  //Component Instances
  alu_transaction  transaction_before;
  alu_transaction  transaction_after;

  //Constructor
  function new(string name, uvm_component parent);
	super.new(name, parent);

	transaction_before	= new("transaction_before");
	transaction_after	= new("transaction_after");
  endfunction: new

  //Build analysis ports and analysis FIFOs
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	sb_export_before	= new("sb_export_before", this);
	sb_export_after		= new("sb_export_after", this);

   	before_fifo		= new("before_fifo", this);
	after_fifo		= new("after_fifo", this);
  endfunction: build_phase

  //Connect analysis ports to analysis FIFOs
  function void connect_phase(uvm_phase phase);
	sb_export_before.connect(before_fifo.analysis_export);
	sb_export_after.connect(after_fifo.analysis_export);
  endfunction: connect_phase

  //Execute analysis, predict outputs and compare to check pass/fail 
  task run();
	forever begin
	  before_fifo.get(transaction_before);
	  after_fifo.get(transaction_after);
		
      predictor();
	  compare();
	end
  endtask: run

	//Comparator between expected and resulted outputs for pass/fail
	virtual function void compare();
		if(transaction_before.out == transaction_after.out) begin
          `uvm_info(get_type_name(),$sformatf("a = %d, b = %d, s = %d, Expected = %d, Resulted = %d", transaction_before.a, transaction_before.b, transaction_before.s, transaction_before.out, transaction_after.out), UVM_LOW);
          `uvm_info("PASSED", {"Test: PASSED "}, UVM_LOW);
		end else begin
          `uvm_info(get_type_name(),$sformatf("a = %d, b = %d, s = %d, Expected = %d, Resulted = %d", transaction_before.a, transaction_before.b, transaction_before.s, transaction_before.out, transaction_after.out), UVM_LOW);
          `uvm_info("FAILED", {"Test: FAILED "}, UVM_LOW);
		end
	endfunction: compare
  
	//Expected result predictor
	virtual function void predictor();
      
      if     (transaction_before.s==0) transaction_before.out=transaction_before.a + transaction_before.b;
      else if(transaction_before.s==1) transaction_before.out=transaction_before.a - transaction_before.b;
      else if(transaction_before.s==2) transaction_before.out=transaction_before.a * transaction_before.b;
      else if(transaction_before.s==3) transaction_before.out=transaction_before.a / transaction_before.b;
      else if(transaction_before.s==4) transaction_before.out=transaction_before.a % transaction_before.b;
      else if(transaction_before.s==5) transaction_before.out=transaction_before.a && transaction_before.b;
      else if(transaction_before.s==6) transaction_before.out=transaction_before.a || transaction_before.b;
      else if(transaction_before.s==7) transaction_before.out=!transaction_before.a;
      else if(transaction_before.s==8) transaction_before.out=~transaction_before.a;
      else if(transaction_before.s==9) transaction_before.out=transaction_before.a & transaction_before.b;
      else if(transaction_before.s==10) transaction_before.out=transaction_before.a | transaction_before.b;
      else if(transaction_before.s==11) transaction_before.out=transaction_before.a ^ transaction_before.b;
      else if(transaction_before.s==12) transaction_before.out=transaction_before.a << 1;
      else if(transaction_before.s==13) transaction_before.out=transaction_before.a >> 1;
      else if(transaction_before.s==14) transaction_before.out=transaction_before.a + 1;
      else if(transaction_before.s==15) transaction_before.out=transaction_before.a - 1; 
	endfunction: predictor
  
endclass: alu_scoreboard