module clockDiv(input clk,
output reg clk1);

reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd10000000;

always @(posedge clk)
begin
	counter <= counter + 28'd1;
	if(counter>=(DIVISOR-1))
	counter <= 28'd0;

	clk1 <= (counter<DIVISOR/2)?1'b1:1'b0;

end
endmodule


/*
module clockDiv_tb();
reg clk;
wire clk1;

initial begin
clk = 0;
end

clockDiv DUT

always@ (posedge clk) begin



end


endmodule

/*
module dff(input D,input clk, input reset, output Q);

wire ground = 1'b0;

always@(posedge clk) begin
	if (reset == 1'b1) begin
		Q=ground; 
	end
	else begin
		Q = D;
	end
end

endmodule
*/