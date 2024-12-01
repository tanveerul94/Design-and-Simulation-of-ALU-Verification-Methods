class driver;
	mailbox gen2driv, driv2sb;
	virtual alu_if.DRIVER aluif;
	transaction d_trans;
	event driven;

	function new(mailbox gen2driv, driv2sb , virtual alu_if.DRIVER aluif, event driven);
		this.gen2driv=gen2driv;
		this.aluif=aluif;
		this.driven=driven;
		this.driv2sb=driv2sb;
	endfunction

	task main(input int count);
		repeat(count) begin
			d_trans=new();
			gen2driv.get(d_trans);
			
			@(aluif.driver_cb);
			aluif.driver_cb.a<= d_trans.a;
			aluif.driver_cb.b<= d_trans.b;
			aluif.driver_cb.s<= d_trans.s;
			driv2sb.put(d_trans);
			-> driven;
		end
	endtask:main

endclass:driver
