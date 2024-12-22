`timescale 1ns/10ps

module multiplexers(input       [2:0]   rout,
                    input               din_en,
                    input               gout,
                    input       [15:0]  r0, r1, r2, r3, r4, r5, r6, r7,
                    input       [15:0]  din,
                    input       [15:0]  aluout,

                    output  reg [15:0]  buswires);

  always @(*) begin
    case({rout, din_en, gout})
      5'b000_0_1:   buswires = aluout;
      5'b000_1_0:   buswires = din;
      5'b000_0_0:   buswires = r0;
      5'b001_0_0:   buswires = r1;
      5'b010_0_0:   buswires = r2;
      5'b011_0_0:   buswires = r3;
      5'b100_0_0:   buswires = r4;
      5'b101_0_0:   buswires = r5;
      5'b110_0_0:   buswires = r6;
      5'b111_0_0:   buswires = r7;

      default:      buswires = buswires;
    endcase // rout
  end
endmodule
