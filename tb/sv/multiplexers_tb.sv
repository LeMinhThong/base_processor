`timescale 1ns/10ps

module multiplexers_tb();
  reg   [2:0]   rout;
  reg           din_en;
  reg           gout;
  reg   [15:0]  r0, r1, r2, r3, r4, r5, r6, r7;
  reg   [15:0]  din;
  reg   [15:0]  aluout;

  wire  [15:0]  buswires;

  multiplexers dut (.rout       (rout),
                    .din_en     (din_en),
                    .gout       (gout),
    
                    .r0         (r0),
                    .r1         (r1),
                    .r2         (r2),
                    .r3         (r3),
                    .r4         (r4),
                    .r5         (r5),
                    .r6         (r6),
                    .r7         (r7),
                    .din        (din),
                    .aluout     (aluout),

                    .buswires   (buswires));

  initial begin
    r0      = 16'h0;
    r1      = 16'h1;
    r2      = 16'h2;
    r3      = 16'h3;
    r4      = 16'h4;
    r5      = 16'h5;
    r6      = 16'h6;
    r7      = 16'h7;
    din     = 16'hd;
    aluout  = 16'hf;

    rout    = 3'h0;
    din_en  = 1'b0;
    gout    = 1'b0;
  end

  initial begin
    for(int i=0; i<=5'b111_0_0; i++) begin
      {rout, din_en, gout} = i;
      #1 $display("@%0t [MULTIPLEXERS]: r0: %0h, r1: %0h, r2: %0h, r3: %0h, r4: %0h, r5: %0h, r6: %0h, r7: %0h, din: %0h, aluout: %0h, rout: %0h, din_en: %0h, gout: %0h, buswires: %0h", $time, r0, r1, r2, r3, r4, r5, r6, r7, din, aluout, rout, din_en, gout, buswires);
    end
    $finish;
  end
endmodule
