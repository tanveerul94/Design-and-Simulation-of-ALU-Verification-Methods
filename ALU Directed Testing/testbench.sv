`timescale 1ns/10ps
module alu_test;
  reg clk;
  reg [7:0] a,b;
  reg [3:0] s;
  wire [15:0] out;
  
  // Clock generation
  initial
    forever #5 clk = ~clk;
  
  // Module instantiation
  alu DUT( .clk (clk),
           .a   (a),
           .b   (b),
           .s   (s),
           .out (out)
  );
  
  initial 
  begin
    clk = 1'b0;
    a = $random;
    b = $random;
    s = 4'bx;
    #30
    s = 0;
    #10
    result_checker(s,a,b,out);
    #10
    s = 14;
    #10
    result_checker(s,a,b,out);
    #10
    s = $random;
    #10
    result_checker(s,a,b,out);
    $finish;
  end	

  // Task : result_checker
  task result_checker(input [3:0] s,input [7:0] a,b,input [15:0]resulted_out);
    reg [15:0] expected_out;
    begin
      if(s==0) expected_out=a + b;
    else if(s==1) expected_out=a - b;
    else if(s==2) expected_out=a * b;
    else if(s==3) expected_out=a / b;
    else if(s==4) expected_out=a % b;
    else if(s==5) expected_out=a && b;
    else if(s==6) expected_out=a || b;
    else if(s==7) expected_out=!a;
    else if(s==8) expected_out=~a;
    else if(s==9) expected_out=a & b;
    else if(s==10) expected_out=a | b;
    else if(s==11) expected_out=a ^ b;
    else if(s==12) expected_out=a << 1;
    else if(s==13) expected_out=a >> 1;
    else if(s==14) expected_out=a + 1;
    else if(s==15) expected_out=a - 1;
    
    if(resulted_out == expected_out)
      $display("Passed : a=%d, b=%d, s=%d, resulted_out=%d, expected_out=%d", a,b,s,resulted_out,expected_out);
    else
      $display("Failed : a=%d, b=%d, s=%d, resulted_out=%d, expected_out=%d", a,b,s,resulted_out,expected_out);
    end
  endtask	

  // Waveform dumping
  initial begin
    $dumpfile("alu_test_dump.vcd");
    $dumpvars;
  end
endmodule
