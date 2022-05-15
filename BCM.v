`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2022 11:27:43
// Design Name: 
// Module Name: BCM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BCM(input clk,rst, input pre,post,output reg signed [17:0]w,r1,r2,o1);//

parameter T_plus = 4; // 16
parameter T_minus = 5; // 32
parameter Ty = 5;
parameter A3_plus = 4;   //  1/16
parameter A2_minus = 7; //   1/128
/// the equations to be implemented 
////   dw1 = o1(t)*A3_minus*r2(t-e);  if t = t_pre 
////   dw2 = r1(t)*A2__plus ;    if t = t_post


reg  signed [17:0] dw;

////////////// REG FOR PIPELINING ///////////////   132 reg
reg  signed [17:0] dw1,dw2,dw_mux1,dw_mux2; // 72 REG
reg  [3:0] r2xo1_mux1;           // 8 REG
reg  [4:0] r2xo1_mux2;           // 10 REG
reg  [5:0] r2xo1_mux3;           // 12 REG
reg  [6:0] r2xo1_mux4;           // 14 REG
reg  [7:0] r2xo1_4;                 // 16 REG 
///////////////////////////////////////////////////

wire signed [17:0] r1_mux,r2_mux,o1_mux;
wire signed [17:0] r2xo1;
wire [5:0] r2xo1_add1;
wire [6:0] r2xo1_add2;
wire [7:0] r2xo1_add3;
wire  [3:0] wire_r2xo1_mux1;           // 8 REG
wire  [4:0] wire_r2xo1_mux2;           // 10 REG
wire  [5:0] wire_r2xo1_mux3;           // 12 REG
wire  [6:0] wire_r2xo1_mux4;           // 14 REG

always@(posedge clk) begin 

if(rst) begin
 
 w <= 18'sh0_0000;
 r1 <= 18'sh1_0000;
 r2 <= 18'sh1_0000;
 o1 <= 18'sh1_0000; 
 dw1 <= 18'sh0_0000;
 dw2 <= 18'sh0_0000;
 dw_mux1 <= 18'sh0_0000;
 dw_mux2 <= 18'sh0_0000;
 dw <= 18'sh0_0000; 
 r2xo1_mux1 <= 0;
 r2xo1_mux2 <= 0;
 r2xo1_mux3 <= 0;
 r2xo1_mux4 <= 0;
 r2xo1_4 <= 0;

 end
else begin 
// update exponcial variables
r1 <= r1_mux;
r2 <= r2_mux;
o1 <= o1_mux;

////////...........................  PIPELINE 1 .........................////////////

// mux output mult4 r2xo1               
r2xo1_mux1 <= wire_r2xo1_mux1;
r2xo1_mux2 <= wire_r2xo1_mux2;
r2xo1_mux3 <= wire_r2xo1_mux3;
r2xo1_mux4 <= wire_r2xo1_mux4;

////////...........................  PIPELINE 2 .........................////////////
// mult1 adder 2
r2xo1_4 <= r2xo1_add3;

////////...........................  PIPELINE 3 .........................////////////
dw1 <= (r2xo1>>>A3_plus);
dw2 <= (r1>>>A2_minus);

////////...........................  PIPELINE 4 .........................////////////
dw_mux1 <= (post)?dw1:18'sh0_0000;
dw_mux2 <= (pre)?dw2:18'sh0_0000;

////////...........................  PIPELINE 5 .........................////////////
dw <= dw_mux1 - dw_mux2;

////////...........................  PIPELINE 6 .........................////////////
w <= w + dw;
     end
end 

assign r1_mux = (post)? 18'sh1_0000:(r1 - (r1>>>T_minus));
assign r2_mux = (pre)? 18'sh1_0000:(r2 - (r2>>>T_plus));
assign o1_mux = (post)? 18'sh1_0000:(o1 - (o1>>>Ty));

assign wire_r2xo1_mux1 = r2[15:12]&{o1[12],o1[12],o1[12],o1[12]};
assign wire_r2xo1_mux2 = ({1'b0,r2[15:12]}<<1)&{o1[13],o1[13],o1[13],o1[13],o1[13]};  
assign wire_r2xo1_mux3 = ({2'b0,r2[15:12]}<<2)&{o1[14],o1[14],o1[14],o1[14],o1[14],o1[14]};
assign wire_r2xo1_mux4 = ({3'b0,r2[15:12]}<<3)&{o1[15],o1[15],o1[15],o1[15],o1[15],o1[15],o1[15]};



/// mult adder 1
assign r2xo1_add1 = {1'b0,r2xo1_mux1} + r2xo1_mux2;
assign r2xo1_add2 = r2xo1_add1 + r2xo1_mux3;
assign r2xo1_add3 = r2xo1_add2 + r2xo1_mux4;

  // mult output wire with addpending 0's at integer part and at least signifient 8 bits
assign r2xo1 = {2'b00,r2xo1_4,8'b0};


endmodule
