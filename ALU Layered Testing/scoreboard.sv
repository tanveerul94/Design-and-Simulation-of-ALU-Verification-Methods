class scoreboard;
	mailbox driv2sb;
	mailbox mon2sb;

	transaction d_trans;
	transaction m_trans;

	event driven;

	function new(mailbox driv2sb, mon2sb);
		this.driv2sb=driv2sb;
		this.mon2sb=mon2sb;
	endfunction

	task main(input int count);
		$display("---Scoreboard Test Starts------------");
		repeat(count) begin
			m_trans=new();
			mon2sb.get(m_trans);
			report();
			if(m_trans.out!= d_trans.out)
				$display("Failed : a=%d b=%d s=%d Expected out=%d Resulted out=%d",d_trans.a, d_trans.b, d_trans.s,d_trans.out, m_trans.out);
			else
				$display("Passed : a=%d b=%d s=%d Expected out=%d Resulted out=%d",d_trans.a, d_trans.b, d_trans.s,d_trans.out, m_trans.out);
		end
		$display("------------------Scoreboard Test Ends----");
	endtask:main

	task report();
		d_trans=new();
		driv2sb.get(d_trans);
        if(d_trans.s==0) d_trans.out=d_trans.a + d_trans.b;
		else if(d_trans.s==1) d_trans.out=d_trans.a - d_trans.b;
		else if(d_trans.s==2) d_trans.out=d_trans.a * d_trans.b;
		else if(d_trans.s==3) d_trans.out=d_trans.a / d_trans.b;
		else if(d_trans.s==4) d_trans.out=d_trans.a % d_trans.b;
		else if(d_trans.s==5) d_trans.out=d_trans.a && d_trans.b;
		else if(d_trans.s==6) d_trans.out=d_trans.a || d_trans.b;
		else if(d_trans.s==7) d_trans.out=!d_trans.a;
		else if(d_trans.s==8) d_trans.out=~d_trans.a;
		else if(d_trans.s==9) d_trans.out=d_trans.a & d_trans.b;
		else if(d_trans.s==10) d_trans.out=d_trans.a | d_trans.b;
		else if(d_trans.s==11) d_trans.out=d_trans.a ^ d_trans.b;
		else if(d_trans.s==12) d_trans.out=d_trans.a << 1;
		else if(d_trans.s==13) d_trans.out=d_trans.a >> 1;
		else if(d_trans.s==14) d_trans.out=d_trans.a + 1;
		else if(d_trans.s==15) d_trans.out=d_trans.a - 1;
	endtask:report
	
endclass:scoreboard
