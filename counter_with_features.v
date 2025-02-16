module counter_with_features(input clk,
input reset, //button
input load, //button
input [3:0] loadData, 
input upDown, //switch
input [1:0] clkSel, //two switches
output [7:0] toDisp1, 
output reg [3:0] counter);

//reg [3:0] counter;
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
		3'b011 : counter = max; //a reset in reverse is the max input, CHANGE IF PROFESSOR DOESNT AGREE!!!!
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
wire [7:0] toDisplay1;
wire [3:0] counterOut;

//initilise variables
initial begin
	clk = 0; reset = 0; load = 0; updown = 0; loadData = 4'b0000; #20
	reset = 1; load = 1; updown = 0; loadData = 4'b0000; #20;
	reset = 1; load = 1; updown = 0; loadData = 4'b0000; #20;
	reset = 1; load = 1; updown = 0; loadData = 4'b0000; #20;
	reset = 1; load = 1; updown = 0; loadData = 4'b0000; #20;
	reset = 1; load = 1; updown = 0; loadData = 4'b0000; #20;//up 5

	reset = 1; load = 1; updown = 1; loadData = 4'b0000; #20;
	reset = 1; load = 1; updown = 1; loadData = 4'b0000; #20;//down 2
	
	#5000 $stop; //breakpoint to end loop
end

//start clock
always begin
	#10; clk = ~clk;
end

//call module to test
counter_with_features test(clk, reset, load, loadData, updown, toDisplay1, counterOut);

//loop through and test module
//always@ (posedge clk) begin
	
//end

//#100; reset = 0; load = 1; updown = 0; loadData = 4'b0000;

//#200; reset = 1; load = 0; updown = 0; loadData = 4'b0010;

endmodule