`timescale 1ns/10ps

module addsub ( input               sub,
                input       [15:0]  raout,
                input       [15:0]  buswires,

                output  reg [15:0]  result);
  always @(*) begin
    case(sub)
      1'b1:     result = raout - buswires;
      1'b0:     result = raout + buswires;

      default:  result = result;
    endcase // sub
  end
endmodule

// ------------------------------------------------------------------

module alu( input               clock,
            input               ain,
            input               gin,
            input               sub,
            input       [15:0]  buswires,
            
            output      [15:0]  aluout);
  
  wire  [15:0]  raout;
  wire  [15:0]  result;

  register #(.WIDTH (16)) a ( .clock (clock), .rin (ain), .buswires (buswires), .r (raout));

  register #(.WIDTH (16)) g ( .clock (clock), .rin (gin), .buswires (result),   .r (aluout));

  addsub addsub0  ( .sub      (sub),
                    .raout    (raout),
                    .buswires (buswires),

                    .result   (result));
endmodule
