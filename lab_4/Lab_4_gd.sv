// adventure game
module Lab_4_gd(input logic reset, clk, N, S, E, W,
				     output logic WIN, DIE);
					  
	logic B, visit, loss, victory;
	
	// adventure game
	room r(reset, clk, N, S, W, E, B, visit, loss, victory);
	sword s(reset, clk, visit, B);
	
	// output logic
	assign WIN = victory;
	assign DIE = loss;
	
endmodule	  
					  
// Room FSM
module room(input logic reset, clk, N, S, W, E, B,
				output logic visit, loss, victory);
	
	typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6} statetype;
	statetype state, nextstate;
	
	// state register
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= S0;
		else state <= nextstate;
	
	// next state logic
	always_comb
		case (state)
			S0:   if (E) nextstate = S1;
					else nextstate = S0;
					
			S1:   if (W) nextstate = S0;
				   else if (S) nextstate = S2;
				   else nextstate = S1;
					
			S2:   if (N) nextstate = S1;
				   else if (W) nextstate = S3;
				   else if (E) nextstate = S4;
				   else nextstate = S2;
					
			S3:	if (E) nextstate = S2; // trigger sword B
					else nextstate = S3;
			
			S4:	if (~B) nextstate = S5;
					else if (E & B) nextstate = S6;
					else if (W & B) nextstate = S2;
					else nextstate = S4;
					
			default: nextstate = S0;
		endcase
	
	// output logic
	assign loss = (state == S5);
	assign victory = (state == S6);
	assign visit = (state == S3);

endmodule

// Sword FSM
module sword(input logic reset, clk, visit,
				output logic B);

	typedef enum logic [1:0] {T0, T1} statetype;
	statetype state, nextstate;
	
	// state register	
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= T0;
		else state <= nextstate;	
	
	// next state logic
	always_comb
		case (state)
			T0: if (visit) nextstate = T1;
				 else nextstate = T0;
			
			T1: if (reset) nextstate = T0;
				 else nextstate = T1;
		endcase
	
	// output logic
	assign B = (state == T1);

endmodule