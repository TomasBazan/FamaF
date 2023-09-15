// CONTROLLER

module controller(input logic [10:0] instr,
						input logic reset, ExtIRQ, ExcAck,
						output logic [3:0] AluControl, EStatus,
						output logic [1:0] AluSrc,
						output logic 	reg2loc, regWrite, Branch,
											memtoReg, memRead, memWrite,
											Exc, ExtIAck, BranchReg, ERet);
											
	logic [1:0] AluOp_s;
	logic  NotAnInstr;
	always_comb begin 
		if (NotAnInstr)begin
			EStatus = 4'b0010;
		end else begin 
			if(reset) begin
				EStatus = 4'b0000;
			end else begin
				if ( ExtIRQ) begin
					EStatus = 4'b0001;
				end else begin
					EStatus = 4'b0000;
				end
			end
		end
	end
	assign ExtIAck = (ExcAck === 1'b1) && (ExtIRQ === 1'b1);
	assign Exc = ExtIRQ || NotAnInstr;
	
	
	maindec 	decPpal 	(.Op(instr), 
							.Reg2Loc(reg2loc), 
							.ALUSrc(AluSrc), 
							.MemtoReg(memtoReg), 
							.RegWrite(regWrite), 
							.MemRead(memRead), 
							.MemWrite(memWrite), 
							.Branch(Branch), 
							.ALUOp(AluOp_s),
							.reset(reset),
							.NotAnInstr(NotAnInstr),
							.BranchReg(BranchReg),
							.ERet(ERet));	
					
								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(AluControl));
endmodule
