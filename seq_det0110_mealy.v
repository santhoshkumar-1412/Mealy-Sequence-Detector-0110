`timescale 1ns/1ps
module seq_det_0110(z,x,clk,rst);
output reg z;
input x,clk,rst;
reg [1:0] state,next_state;
parameter A=2'b00,
          B=2'b01,
          C=2'b10,
          D=2'b11;
always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= A;
    else
        state <= next_state;
end
always @(*)
begin
    next_state = A;
    z = 0;
    case(state)
    A: if(x==0) next_state = B;
       else     next_state = A;
    B: if(x==0) next_state = B;
       else     next_state = C;
    C: if(x==0) next_state = B;
       else     next_state = D;
    D: if(x==0)
       begin
           next_state = B;
           z = 1;
       end
       else
           next_state = A;
    default:
    begin
        next_state = A;
        z = 0;
    end
    endcase
end
endmodule
