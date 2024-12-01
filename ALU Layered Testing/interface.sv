interface alu_if(input clk);
	logic [7:0] a,b;
	logic [3:0] s;
	logic [15:0] out;
	
	clocking driver_cb @(negedge clk);
		default input #3 output #2;
		output a,b,s;
	endclocking

	clocking mon_cb @(negedge clk);
		default input #3 output #2;
		input a,b,s;
		input out;
	endclocking

	modport DRIVER (clocking driver_cb, input clk);
	modport MONITOR (clocking mon_cb, input clk);

endinterface
