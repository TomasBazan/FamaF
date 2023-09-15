module execute #(parameter N = 64)(
				input logic AluSrc,
				input logic [3:0] AluControl,
				input logic [N-1:0] PC_E,signImm_E, readData1_E, readData2_E,
				output logic zero_E,
				output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E);
	logic [N-1:0] sl2_to_add, mux_to_alu;
	assign writeData_E = readData2_E;
	adder #(N) myAdder (PC_E,sl2_to_add, PCBranch_E);

	alu myAlu (readData1_E, mux_to_alu, AluControl, aluResult_E, zero_E);
	
	mux2 #(N) myMux(readData2_E, signImm_E, AluSrc, mux_to_alu);
	
	sl2 #(N) mySl2 (signImm_E, sl2_to_add);

endmodule