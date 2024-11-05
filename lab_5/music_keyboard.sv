module music_keyboard(input logic reset, clk, 
							 input logic k0, k1, k2, k3,
							 output logic q);
						 
	logic [31:0] q0, q1, q2, q3; // N = 32 bits
	
	//keys
	always_ff @(posedge clk) // note C
		if (reset) q0 <= 0;
		else q0 <= q0+22471; //q + p
		
	always_ff @(posedge clk) // note E
		if (reset) q1 <= 0;
		else q1 <= q1+28312; //q + p
		
	always_ff @(posedge clk) // note G
		if (reset) q2 <= 0;
		else q2 <= q2+33673; //q + p
		
	always_ff @(posedge clk) // note A
		if (reset) q3 <= 0;
		else q3 <= q3+37796; //q + p

	//output of MUX
	//assigns q to a frequency if a button is pressed
	assign q =  ~k0 ? q0[31] : 
				  (~k1 ? q1[31] : 
				  (~k2 ? q2[31] : 
				  (~k3 ? q3[31] : 
					0))); 
endmodule