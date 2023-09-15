`timescale 1ns / 10ps
module execute_tb #(parameter N = 64)();
	logic AluSrc;
	logic [3:0] AluControl;
	logic [N-1:0] PC_E,signImm_E, readData1_E, readData2_E;
	logic zero_E;
	logic [N-1:0] PCBranch_E, aluResult_E, writeData_E;
	

	execute #(N) dut (AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E, zero_E, PCBranch_E, aluResult_E, writeData_E);
	
	initial begin
		AluSrc = 1'b0;
		AluControl = 4'b0111;
		PC_E = 64'h0000_0000_0000_0001;
		signImm_E = 64'h0000_0000_0000_000F;
		readData1_E = 64'h0000_0000_0000_000E;
		readData2_E = 64'h0000_0000_0000_000A;
		#10;
		$stop;
		// shoul give me 64'h0000_0000_0000_0002
		
		//outputs
		// zero_E
		// PCBranch_E=
		// aluResult_E=
		// writeData_E=
		
	end
						
endmodule