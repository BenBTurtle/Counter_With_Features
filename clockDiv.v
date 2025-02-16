module clockDivide(input clk, input [1:0] clkSel, output reg divClk);

reg [27:0] counterDiv, selThresh;

initial begin
	divClk <= 0;
end

always@(*) begin
	case(clkSel) 
		2'b00 : selThresh <= 28'd12500000; //0.5 sec
		2'b01 : selThresh <= 28'd25000000; //1 sec
		2'b10 : selThresh <= 28'd50000000;//2 sec
		2'b11 : selThresh <= 28'd100000000;//4 sec (not a requirement, but fills out the mux)
		default : selThresh <= 28'd50000000; //1sec is default case
	endcase
end

always@ (posedge clk) begin
	counterDiv <= counterDiv+1;
	
	if (counterDiv == selThresh) begin
		divClk = ~divClk;
		counterDiv <= 0;
	end
end

endmodule


//depreciated approach that I refuse to delete
/*
module clockDivide(input clk, output sec1, output sec2, output secHalf);

	wire [23:0] QpToD, dividedClk;
	wire dummy;
	genvar i;
	
	dFF theFirst( QpToD[0],  clk, dividedClk[0], QpToD[0]);
	
	generate
		for (i = 1; i<24; i=i+1) begin : dFlipFlopChain
			dFF secondThroughFinal( QpToD[i], dividedClk[i-1], dividedClk[i], QpToD[i]);
		end
	endgenerate
	
	assign secHalf = dividedClk[23];
	assign sec1 = dividedClk[22];
	assign sec2 = dividedClk[21];
	
endmodule




// d flip flop Deprecated code
module dFF(input D, input clk, output reg Q, output reg Qp);


	always@ (posedge clk) begin
		Q <= D;
		Qp <= ~Q;
	end

endmodule



`timescale 1ns/1ps
module clockDivider_TB();
reg clk;
wire sec1, sec2, secHalf;

clockDivide DUT(clk, sec1, sec2, secHalf);

initial begin //initilise the clock
	clk <= 0;
end

always@ (posedge clk) begin
	clk = ~clk;
end
	
endmodule

*/