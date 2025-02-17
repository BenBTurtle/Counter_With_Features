module counter_with_features(input clk,
input reset, //button
input load, //button
input [3:0] loadData, 
input upDown, //switch
input [1:0] clkSel, //two switches
output [7:0] toDisp1, 
output reg [3:0] counter);

wire [3:0] zero = 4'b0000, max = 4'b1111, debug = 4'b0110; //debug has seemingly random value for ease of debugging
wire [2:0] cond = {reset, upDown, load};

initial begin
	counter = 0;
end

wire clkRed;
clockDivide divideC(clk, clkSel, clkRed);

always @(posedge clkRed) begin
	case (cond)
		3'b101 : counter = (counter == max)? zero : counter+1; //base counter increase with checker for overflow
		3'b100 : counter = loadData; //load input
		3'b111 : counter = (counter == zero)? max : counter-1; //basic deincrementer with underflow checker
		3'b110 : counter = loadData; //load data priotised over upDown as that will be used next clock cycle
		3'b001 : counter = zero; //reset alone
		3'b000 : counter = loadData; //priortising the load input rather than the reset input (both buttons pressed)
		3'b011 : counter = max; //a reset in reverse is the max input
		3'b010 : counter = loadData; //loadData once again priortised as the other two functions will happen next clock cycle
		//default : counter = debug;
		default: counter = counter+1; //default case of increment as this is the most basic function
	endcase
	

end

hexSevenSegmentDecoder display1(counter, toDisp1);

endmodule


`timescale 1ns/1ps

module counter_with_features_TB();
reg clk, reset, load, updown;
reg [3:0] loadData;
reg [1:0] clkSel;
wire [7:0] toDisplay1;
wire [3:0] counterOut;

always begin
	#10; clk = ~clk;
end



//initilise variables
initial begin
	clk = 0; reset = 1'b1; load = 1'b1; updown = 1'b0; loadData = 4'b0000; clkSel = 2'b00; #50; //initial counting
	reset = 1'b0; load = 1'b1; updown = 1'b0; loadData = 4'b0000; clkSel = 2'b00; #10; //check for reset functionality after 5 counts
	reset = 1'b1; load = 1'b1; updown = 1'b0; loadData = 4'b0000; clkSel = 2'b00; #100; //count after reset for 10 sec
	reset = 1'b1; load = 1'b1; updown = 1'b1; loadData = 4'b0000; clkSel = 2'b00; #150; //swap direction for 20 sec
	reset = 1'b1; load = 1'b0; updown = 1'b1; loadData = 4'hb; clkSel = 2'b01; #10; //swapped direction and loading value 'b', also decreased clock to 1sec
	reset = 1'b1; load = 1'b1; updown = 1'b1; loadData = 4'hb; clkSel = 2'b10; #200; //counting from b with swapped direction for 20sec, also further decreased clock to 2ssec
	$stop;
end

//start clock


counter_with_features DUT(clk, reset, load, loadData, updown, clkSel, toDisplay1, counterOut);



endmodule