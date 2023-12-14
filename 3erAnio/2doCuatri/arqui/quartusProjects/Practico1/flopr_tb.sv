`timescale 1ns / 10ps
module flopr_tb #(parameter n = 64)();
	logic    clk, reset;
	logic    [n-1 : 0] a;
	logic 	[n-1 : 0] y, yexpected;
	logic 	[n-1 : 0] vectornum, errors;    // bookkeeping variables 
	logic 	[n-1 : 0] testvectors [0:9] = '{ 64'h0000_0000_0000_0001,	// array of testvectors
															64'h0000_0000_0000_0002,
															64'h0000_0000_0000_0003,
															64'h0000_0000_0000_0004,
															64'h0000_0000_0000_0005,
															64'h0000_0000_0000_0006,
															64'h0000_0000_0000_0007,
															64'h0000_0000_0000_0008,
															64'h0000_0000_0000_0009,
															64'h0000_0000_0000_000A};	
	/*
	module flopr #(parameter N = 64)
					(input logic clk,
					input logic reset,
					input logic [N-1:0] d,
					output logic [N-1:0] q);
	*/
	// instantiate device under test
	flopr #(32) dut(clk, reset, a, y);
  
  
	// generate clock
	always     // no sensitivity list, so it always executes
		begin
			clk = 0; #5; clk = 1; #5;
		end
		
 
	// at start of test pulse reset
	initial 	
		begin     
			vectornum = 0; errors = 0;
			reset = 1; #52; reset = 0;		
		end
	 
	 
	// apply test vectors on rising edge of clk
	always @(negedge clk)
		begin
			#1; a = testvectors[vectornum];
		end
		
 
	// check results on falling edge of clk
   always @(posedge clk) begin
		if (~reset) begin 
			#1;
			if (y !== a) begin  
				$display($realtime);
				$display("Error: in %d ns inputs = %b",clk, a);
				$display("  outputs = %b must be %b",y,a);
				errors = errors + 1;
			end		
		end
		if (reset) begin // skip during reset
			if (y !== 64'b0) begin  
				$display("Error: inputs = %b", a);
				$display("  outputs = %b must be zero",y);
				errors = errors + 1;
			end
		end

		// increment array index and read next testvector
      vectornum = vectornum + 1;
			if (testvectors[vectornum] === 64'bx) begin 
				$display("%d tests completed with %d errors", 
                vectornum, errors);
			//  $finish;
				$stop;
			end
	end
endmodule