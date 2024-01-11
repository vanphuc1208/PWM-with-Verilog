`timescale 1ns / 1ps

module PWM(
input clk, rst,
output reg dout
);
integer period=50; // we can mo?ify the time period = cycle of clock * period 
integer Ton=0; // The time the signal is on in a cycle.
reg cycle_flag=0; // indicate that we have finished a cycle.
integer count=0;
always@(posedge clk)
begin
if(rst == 1'b1)
    begin
    dout <= 1'b0;
    count<=0;
    Ton<=0;
    cycle_flag <=0;
    end
else 
    begin
    if(count < Ton) 
        begin
        dout<=1'b1;
        count<=count + 1;
        cycle_flag <=1'b0;
        end
     else if (count < period)
        begin
        dout<=1'b0;
        count<=count + 1;
        cycle_flag <=1'b0;
        end
     else begin
        cycle_flag <=1'b1;
        count<=0;
        end
    end
end
reg decrease= 0;
always@(posedge clk)
    if(rst == 1'b0) begin
        if(cycle_flag == 1'b1) begin
            if (Ton < period - 5 && decrease == 1'b0) begin
                Ton <= Ton + 5;
            end
            else  begin
                Ton<=Ton - 5;
                if (Ton <= 5) decrease=1'b0;
                else decrease <= 1'b1; 
            end
        
        end
    end
endmodule
