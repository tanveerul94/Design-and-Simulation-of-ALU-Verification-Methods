  //Declare assertion properties for functional coverage determination
  property addition;
    logic [7:0] op_a, op_b;
	//Check consequent expression in the same clock tick as antecedent expression
    @(negedge clk) (s == 0, op_a = a, op_b = b) |->  (out == (op_a+op_b));
  endproperty
  assert property (addition);
  cover property (addition);

  property subtraction;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 1, op_a = a, op_b = b) |->  out == (op_a - op_b);
  endproperty
  assert property (subtraction);
  cover property (subtraction);
    
  property multiplication;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 2, op_a = a, op_b = b) |->  out == (op_a * op_b);
  endproperty
  assert property (multiplication);
  cover property (multiplication);
    
  property division;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 3, op_a = a, op_b = b) |->  out == (op_a / op_b);
  endproperty
  assert property (division);
  cover property (division);
    
  property modulo_division;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 4, op_a = a, op_b = b) |->  out == (op_a % op_b);
  endproperty
  assert property (modulo_division);
  cover property (modulo_division);
    
  property logical_and;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 5, op_a = a, op_b = b) |-> (out == (op_a && op_b));
  endproperty
  assert property (logical_and);
  cover property (logical_and);
    
  property logical_or;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 6, op_a = a, op_b = b) |->  out == (op_a || op_b);
  endproperty
  assert property (logical_or);
  cover property (logical_or);
    
  property logical_negation;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 7, op_a = a, op_b = b) |->  out == !op_a;
  endproperty
  assert property (logical_negation);
  cover property (logical_negation);
    
  property bitwise_negation;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 8, op_a = a, op_b = b) |->  out == ~op_a;
  endproperty
  assert property (bitwise_negation);
  cover property (bitwise_negation);
    
  property bitwise_and;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 9, op_a = a, op_b = b) |->  out == (op_a & op_b);
  endproperty
  assert property (bitwise_and);
  cover property (bitwise_and);
    
  property bitwise_or;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 10, op_a = a, op_b = b) |->  out == (op_a | op_b);
  endproperty
  assert property (bitwise_or);
  cover property (bitwise_or);
    
  property bitwise_xor;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 11, op_a = a, op_b = b) |->  out == (op_a ^ op_b);
  endproperty
  assert property (bitwise_xor);
  cover property (bitwise_xor);
    
  property left_shift;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 12, op_a = a, op_b = b) |->  out == op_a << 1;
  endproperty
  assert property (left_shift);
  cover property (left_shift);
    
  property right_shift;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 13, op_a = a, op_b = b) |->  out == op_a >> 1;
  endproperty
  assert property (right_shift);
  cover property (right_shift);
    
  property increment;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 14, op_a = a, op_b = b) |->  out == op_a + 1;
  endproperty
  assert property (increment);
  cover property (increment);
    
  property decrement;
    logic [7:0] op_a, op_b;
    @(negedge clk) (s == 15, op_a = a, op_b = b) |->  out == op_a - 1;
  endproperty
  assert property (decrement);
  cover property (decrement);