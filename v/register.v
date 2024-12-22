`timescale 1ns/10ps

module register #(parameter WIDTH = 16) (
                input                   clock,
                input                   rin,
                input       [WIDTH-1:0] buswires,
                
                output  reg [WIDTH-1:0] r);

  always @(posedge clock) begin
    if(rin) begin
      r <= buswires;
    end
    else begin
      r <= r;
    end
  end
endmodule
