// Behavioral Verilog explains relationships between inputs and outputs
// For example, >>> assign y = a & b;
// Structural Verilog describes structures formed by simpler components
// For example, >>> and g1(y, a, b);
// Section 4.2 & 4.3 in the book(p. 177) describes these differences in detail

// Is this module structural or behavioral?
module fulladder(input logic a,b, cin,
					  output logic sum, cout);
	// Declare 5 internal logic signals or local variables
	// which can only be used inside of this module
	logic ns, n1, n2, n3, n4;

	// The following logic gates are part of SystemVerilog Spec
	// (built-in primitives).
	// The first signal (eg. ns) is the output. The rest(eg. a, b) are
	// inputs.
	
	// sum logic
	xor x1(ns, a, b); // ns = a XOR b
	xor x2(sum, ns, cin); // sum = ns XOR cin

	// carry logic
	and a1(n1, a, b); // n1 = a & b
	and a2(n2, a, cin); // n2 = a & cin
	and a3(n3, b, cin); // n3 = b & cin
	or o1(n4, n1, n2); // n4 = n1 | n2
	or o2(cout, n3, n4); // cout = n3 | n4

// This example is Structural Verilog because the module is described
// structurally using more fundamental building blocks
endmodule