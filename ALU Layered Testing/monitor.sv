class monitor;
	mailbox mon2sb;
	virtual alu_if.MONITOR aluif;
	transaction m_trans;
	event driven;

	function new(mailbox mon2sb, virtual alu_if.MONITOR aluif, event driven);
		this.mon2sb=mon2sb;
		this.aluif=aluif;
		this.driven=driven;
	endfunction

	task main(input int count);
		@(driven);
		@(aluif.mon_cb);
		repeat(count) begin
			m_trans=new();
			@(posedge aluif.clk);
			m_trans.out=aluif.mon_cb.out;
			mon2sb.put(m_trans);
		end
	endtask:main

endclass:monitor
