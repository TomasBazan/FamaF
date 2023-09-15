//    96'b1111_1000_0100_0000_1000_0000_0100_0101_{55{1'b0}_0000_0100_0}
`timescale 1ns / 10ps
module signext_tb ();
	logic    [31 : 0] entrada;
	logic 	[63 : 0] salida;
	logic 	[63 : 0] vectornum;
	logic 	[31 : 0] testvectors [0:5] = '{  32'b1111_1000_0100_0000_1000_0000_0100_0101,		// LDUR X5 [X2, #8]
															32'b1111_1000_0101_0000_1000_0000_0100_0101, 	// LDUR X5 [X2, #-8]
															32'b1111_1000_0000_0001_0000_0000_1010_0011, 	// STUR x3 [x5,#16]
															32'b1111_1000_0001_0001_0000_0000_1010_0011,		// STUR x3 [x5,#-16]
															32'b1011_0100_0000_0000_0000_0001_0000_0101,		// CBZ x5, #8 
															32'b1011_0100_1000_0000_0000_0001_0000_0101};	// CBZ x5, #-8 
	
	// R[Rt] = M[R[RN] + DTAddr]
	
	// LDUR X5 [X2, #8] en x2 mas 8 guardo lo del x5
	// LDUR Pos 111_1100_0010 0000_0100_0 00 0001_0 0010_1a
	// LDUR Neg 111_1100_0010 1000_0100_0 00 0001_0 0010_1
	// LDUR X5 [X2, #-8]
 	
	// M[R[Rn] + DTAddr] = R[Rt]
	// STUR x3 [x5,# ]
	// STUR Pos 111_1100_0000 0000_1000_0 00  0010_1 0001_1
	// STUR Neg 111_1100_0000 1000_1000_0 00  0010_1 0001_1
	
	// CBZ  101_1010_0???
	/* if(R[Rt] == 0)
			PC= PC + CondBranchAddr
	*/
	// CBZ x5, #8 salto 8 instrucciones si x5 es cero
	// 101_1010_0??? 0000_0000_0000_0001_000 0010_1
	// 101_1010_0??? 1000_0000_0000_0001_000 0010_1
	
	signext prueba(entrada, salida);
  
	initial begin
		vectornum = 0;
	end

	always
	begin
		if (vectornum === 6) begin 
				$display("%d tests completed", 
                vectornum);
				$stop;
		end
		#1; entrada = testvectors[vectornum];
		#1;vectornum = vectornum+1;
		
		casez(entrada)
			32'b1111_1000_0100_0000_1000_0000_0100_0101: if (salida !== 64'b1000) $display("Error en %d numero. Input %b output:%b",vectornum,entrada,salida);
			32'b1111_1000_0101_0000_1000_0000_0100_0101:	if (salida !== { {56'hFF_FFFF_FFFF_FFFF, 8'b1000}}) $display("Error en %d numero. Input %b output:%b",vectornum,entrada,salida);
			32'b1111_1000_0000_0001_0000_0000_1010_0011: if (salida !== 64'b10000) $display("Error en %d numero. Input %b output:%b",vectornum,entrada,salida);
			32'b1111_1000_0001_0001_0000_0000_1010_0011:	if (salida !== { {56'hFF_FFFF_FFFF_FFFF, 8'b10000}}) $display("Error en %d numero. Input %b output:%b",vectornum,entrada,salida);
			32'b1011_0100_0000_0000_0000_0001_0000_0101: if (salida !== 64'b1000) $display("Error en %d numero. Input %b output:%b",vectornum,entrada,salida);
			32'b1011_0100_1000_0000_0000_0001_0000_0101: if (salida !== { {45'hF_FFFF_FFFF_FFFF, 19'h4_0008}}) $display("Error en %d numero. Input %b output:%b",vectornum,entrada,salida);
		endcase
	end
endmodule
