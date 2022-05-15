`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2022 11:46:52
// Design Name: 
// Module Name: test
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


module test( );

reg clk,rst,pre,post;
wire signed [17:0] W,R1,R2,o1;
integer T = 20;

BCM  Synaps1(clk,rst,pre,post,W,R1,R2,o1);


initial 
begin 

clk = 0; rst = 1;pre = 0;post=0;

#20 rst = 0;pre = 1;
#2 pre = 0;
#T post = 1;
#2 post = 0;
#T pre = 1;
#2 pre = 0;
#T post = 1;
#2 post = 0;
#T post = 1;
#2 post = 0;
#T pre = 1;
#2 pre = 0;
#T post = 1;
#2 post = 0;
#T pre = 1;
#2 pre = 0;
#T post = 1;
#2 post = 0;
#T post = 1;
#2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;


T = 100;

#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;
#T pre = 1;  #2 pre = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0; #T post = 1; #2 post = 0; #T pre = 1; #2 pre = 0; #T post = 1; #2 post = 0;


#20 $finish;


end

always#(1) clk = ~clk;

endmodule
