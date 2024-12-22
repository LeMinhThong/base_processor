`timescale 1ns/10ps

module counter( input   wire        clock,
                input   wire        clear,

                output  reg   [1:0] state);
  
  always @(posedge clock) begin
    if(clear) begin
      state <= 2'b00;
    end
    else begin
      state <= state +1;
    end
  end
endmodule
