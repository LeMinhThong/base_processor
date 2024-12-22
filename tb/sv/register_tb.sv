`timescale 1ns/10ps

module register_tb();
  reg           rin;
  reg           clock;
  reg   [15:0]  buswires;

  wire  [15:0]  r;

  register  #(.WIDTH (16)) dut (.clock    (clock),
                                .rin      (rin),
                                .buswires (buswires),

                                .r        (r));

  initial begin
    clock     = 1'b0;
    rin       = 1'b0;
    buswires  = 16'b0;

    #40 rin       = 1'b1;
    #40 buswires  = 16'habcd;
    #40 rin       = 1'b0;
    #40 buswires  = 16'b1111;
    #40 rin       = 1'b1;
    #40 $finish;
  end

  initial begin
    $monitor("@%0t [REGISTER]: buswires: %0h, rin: %0b, r: %0h", $time, buswires, rin, r);
  end

  always #10 clock = ~clock;
endmodule
