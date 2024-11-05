module flopr(input logic	clk,
				 input logic	reset,
				 input logic [6:0] d,
				 output logic [6:0] q);

	// asynchoronous reset
	always_ff@(posedge clk, posedge reset)
		if (reset) q <= 7'b0000001;
		else		  q <= d;
endmodule
		
module tbird_signal(input logic clk,
	input logic reset,
	input logic left, right,
	output logic la, lb, lc, ra, rb, rc
	);
	
	logic [6:0] St_prime, St;
	
	logic n1, n2, n3, n4;
	flopr f(clk, reset, St_prime, St);
	
	// state 0
	nor r1(n1, left, right);
	and a7(n4, n1, St[0]);
	or o1(St_prime[0], n4, St[3], St[6]);
	
	buf b9(St_prime[6], St[5]);
	buf b8(St_prime[5], St[4]);
	buf b7(St_prime[3], St[2]);
	buf b11(St_prime[2], St[1]);

	// state 1
	not no1(n2, right);
	and a1(St_prime[1], left, n2, St[0]); 
	
	// state 4
	not no2(n3, left);
	and a2(St_prime[4], n3, right, St[0]);
	
	
	// outputs
	or a3(la, St[1], St[2], St[3]);
	or a4(lb, St[2], St[3]);
	buf b3(lc, St[3]);
	
	or a5(ra, St[4], St[5], St[6]);
	or a6(rb, St[5], St[6]);
	buf b6(rc, St[6]);

endmodule