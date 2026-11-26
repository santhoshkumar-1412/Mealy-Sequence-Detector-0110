`timescale 1ns/1ps
module seq_det_0110_tb;
wire z;
reg clk,rst,x;
seq_det_0110 dut (.z(z),.clk(clk),.rst(rst),.x(x));
always #5 clk = ~clk;
initial begin
clk = 0;
rst = 1;
x = 0;
#10 rst = 0;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#20 $finish;
end
initial begin
    $monitor("Time=%0t | rst=%b | x=%b | state=%b | next_state=%b | z=%b",$time, rst, x, dut.state, dut.next_state, z);
    $dumpfile("seq_det_0110_mealy.vcd");
    $dumpvars(0,seq_det_0110_tb);
end
endmodule
