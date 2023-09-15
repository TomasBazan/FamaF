module fetch 	#(parameter N = 64) (input logic PCSrc_F, clk, reset,
					input logic [N-1:0] PCBranch_F,
					output logic [N-1:0] imem_addr_F);
	logic [N-1:0] muxToPc, addToMux;
	
	mux2 myMux (addToMux,PCBranch_F,PCSrc_F,muxToPc);
	flopr programCounter (clk,reset,muxToPc,imem_addr_F);
	adder myAdd (imem_addr_F,N'('d4),addToMux);
	
endmodule
