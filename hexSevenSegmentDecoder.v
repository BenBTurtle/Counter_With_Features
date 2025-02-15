module hexSevenSegmentDecoder(input [3:0] in,
output [7:0] out);

reg [7:0] wout;

always@ (*) begin
	case(in)
		4'h0: wout = 8'b11000000;
		4'h1: wout = 8'b11111001;
		4'h2: wout = 8'b10100100;
		4'h3: wout = 8'b10110000; 
		4'h4: wout = 8'b10011001; 
		4'h5: wout = 8'b10010010; 
		4'h6: wout = 8'b10000010; 
		4'h7: wout = 8'b11111000; 
		4'h8: wout = 8'b10000000;
		4'h9: wout = 8'b10010000;
		4'ha: wout = 8'b10001000;
		4'hb: wout = 8'b10000011;
		4'hc: wout = 8'b11000110;
		4'hd: wout = 8'b10100001;
		4'he: wout = 8'b10000110;
		4'hf: wout = 8'b10001110; 
		default: wout = 8'b10000000;
	endcase
end

assign out = wout;

endmodule