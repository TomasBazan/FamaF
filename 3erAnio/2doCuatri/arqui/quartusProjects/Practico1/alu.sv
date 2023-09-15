module alu (input logic [63:0] a,
				input logic [63:0] b,
				input logic [3:0] ALUControl,
				output logic [63:0] result,
				output logic zero);		
	always_comb begin
			casez(ALUControl)
				
				4'b0000:	result = a & b; 		//AND
				4'b0001:	result = a | b;		//OR    ESTA MAL ME DEVUELVE 1 CUANDO DEBERIA DEVOLVER 0
				4'b0010: result = a + b;	//add
				4'b0110: result = a - b;	//sub
				4'b0111: result = b;			//pass input
				default:result = '1;
		endcase
		zero = result === '0 ? '1 : '0;
	end
endmodule
