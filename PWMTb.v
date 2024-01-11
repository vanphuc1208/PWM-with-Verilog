`timescale 1ns / 1ps


module PWMTb();
reg clk = 0,rst;
wire dout;

PWM dut(clk,rst,dout);
always #1 clk=~clk;

initial begin
rst =1'b0;
#5000;
rst =1'b1;
#10;
rst = 1'b0;
#2000;
$finish;
end
endmodule
