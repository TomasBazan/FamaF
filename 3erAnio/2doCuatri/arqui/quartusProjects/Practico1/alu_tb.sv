module alu_tb();

	logic [196:0] inputs_and_expected_outputs [29:0] = {
		//a       b         control  result    zero
		{64'd0  , 64'd0   , 4'b0000, 64'd0   , 1'b1}, // &
		{64'd0  , 64'd0   , 4'b0001, 64'd0   , 1'b1}, // |
		{64'd0  , 64'd0   , 4'b0010, 64'd0   , 1'b1}, // +
		{64'd0  , 64'd0   , 4'b0110, 64'd0   , 1'b1}, // -
		{64'd0  , 64'd0   , 4'b0111, 64'd0   , 1'b1}, // pass b

		{64'd593, 64'd0   , 4'b0000, 64'd0   , 1'b1}, // &
		{64'd593, 64'd0   , 4'b0001, 64'd593 , 1'b0}, // |
		{64'd593, 64'd0   , 4'b0010, 64'd593 , 1'b0}, // +
		{64'd593, 64'd0   , 4'b0110, 64'd593 , 1'b0}, // -
		{64'd593, 64'd0   , 4'b0111, 64'd0   , 1'b1},  // pass b

		{64'd0  , -64'd635, 4'b0000, 64'd0   , 1'b1}, // &
		{64'd0  , -64'd635, 4'b0001, -64'd635, 1'b0}, // |
		{64'd0  , -64'd635, 4'b0010, -64'd635, 1'b0}, // +
		{64'd0  , -64'd635, 4'b0110, 64'd635 , 1'b0}, // -
		{64'd0  , -64'd635, 4'b0111, -64'd635, 1'b0}, // pass b

		{64'd239, 64'd26  , 4'b0000, 64'd10  , 1'b0}, // &
		{64'd239, 64'd26  , 4'b0001, 64'd255 , 1'b0}, // |
		{64'd239, 64'd26  , 4'b0010, 64'd265 , 1'b0}, // +
		{64'd239, 64'd26  , 4'b0110, 64'd213 , 1'b0}, // -
		{64'd239, 64'd26  , 4'b0111, 64'd26  , 1'b0}, // pass b

		{-64'd98, -64'd407, 4'b0000, -64'd504, 1'b0}, // &
		{-64'd98, -64'd407, 4'b0001, -64'd1  , 1'b0}, // |
		{-64'd98, -64'd407, 4'b0010, -64'd505, 1'b0}, // +
		{-64'd98, -64'd407, 4'b0110, 64'd309 , 1'b0}, // -
		{-64'd98, -64'd407, 4'b0111, -64'd407, 1'b0}, // pass b

		{64'd930, -64'd33 , 4'b0000, 64'd898 , 1'b0}, // &
		{64'd930, -64'd33 , 4'b0001, -64'd1  , 1'b0}, // |
		{64'd930, -64'd33 , 4'b0010, 64'd897 , 1'b0}, // +
		{64'd930, -64'd33 , 4'b0110, 64'd963 , 1'b0}, // -
		{64'd930, -64'd33 , 4'b0111, -64'd33 , 1'b0}  // pass b
	};

	logic [63:0] a, b;
	logic [3:0] ALUControl;
	logic [63:0] result, expected_result;
	logic zero, expected_zero;

	alu dut(a, b, ALUControl, result, zero);

	logic [31:0] errors;
	always begin
		errors = 0;

		for (int i=0; i<10; ++i) begin
			#1ns;
			{a, b, ALUControl, expected_result, expected_zero} = inputs_and_expected_outputs[i];
			#1ns;
			if (result !== expected_result) begin
				$display("ERROR: result !== expected_result with i = %d", i);
				errors++;
			end
			if (zero !== expected_zero) begin
				$display("ERROR: zero !== expected_zero with i = %d", i);
				errors++;
			end
			#1ns;
		end
		$display("Total errors: %d", errors);
		$stop;
	end


endmodule


/*`timescale 1ns / 10ps
module alu_tb();
	logic    [63:0] a_tb, b_tb;
	logic 	[3:0] ALUControl_tb;    // bookkeeping variables 
	logic 	[63:0] result_tb, vectornum, errors;
	logic 	[63:0] resultExpected;
	logic 	zeroExpected;
	logic 	zero_tb;
	logic 	[196:0] entry_test_vect;
	logic 	[196:0] testvectors [0:9] = '{ 	{5'h0_0, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0001}, 	// 1 AND 1: out 1
															{5'h1_0, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0000, 64'h0000_0000_0000_0000}, 	// 1 AND 0: out 0
															{5'h0_1, 64'h0000_0000_0000_FFFF, 64'h0000_0000_0000_0000, 64'h0000_0000_0000_FFFF}, 	// 1 OR 0: out 1
															{5'h1_1, 64'h0000_0000_0000_0000, 64'h0000_0000_0000_0000, 64'h0000_0000_0000_0000}, 	//	0 OR 0: out 0
															{5'h0_2, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0002}, 	//	1 ADD 1: out 2
															{5'h0_2, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0003, 64'h0000_0000_0000_0004}, 	//	1 ADD 3: out 4
															{5'h1_6, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0000}, 	//	1 SUB 1 : out 0
															{5'h0_6, 64'h0000_0000_0000_0003, 64'h0000_0000_0000_0001, 64'h0000_0000_0000_0002}, 	//	3 SUB 1 : out 2
															{5'h0_7, 64'h0000_0000_0000_CAFE, 64'h0000_0000_0000_000F, 64'h0000_0000_0000_000F}, 	//	CAFE PASS input: out F
															{5'h1_7, 64'h0000_EAAA_BEBE_CAFE, 64'h0000_0000_0000_0000, 64'h0000_0000_0000_0000}}; 	//	0 PASS input: out 0
				
				
	// instantiate device under test
	alu algo(a_tb, b_tb, ALUControl_tb, result_tb, zero_tb);
 
	// at start of test pulse reset
	initial 	
		begin     
			vectornum = 0; errors = 0;
		end
		
	always_comb begin
		
		zeroExpected = entry_test_vect[196];
		ALUControl_tb = entry_test_vect[195:192];
		a_tb = entry_test_vect[191:128];
		b_tb= entry_test_vect[127:64];
		resultExpected = entry_test_vect[63:0];
		
		
	end
   always begin
		entry_test_vect = testvectors[vectornum];
		
		if(resultExpected !== result_tb) begin
			$display("Error en el resultado de la operacion %d. result %h should be %h",vectornum, result_tb, resultExpected);
			errors = errors +1;
		end
		if(zeroExpected !== zero_tb) begin
			$display("Error en el zero en la operacion %d. result %h should be %h",vectornum, zero_tb, zeroExpected);
			errors = errors +1;
		end
		#1;vectornum = vectornum + 1;#1;
		if (vectornum === 11) begin 
			$display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end
endmodule
*/