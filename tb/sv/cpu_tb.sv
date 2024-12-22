`timescale 1ns/10ps

module cpu_tb();

  reg           clock;
  reg           resetn;

  wire          run;
  wire  [15:0]  din;
  wire  [15:0]  dout;
  wire          done;

  cpu cpu0( .clock  (clock),
            .resetn (resetn),
            .run    (run),
            .din    (din),

            .done   (done));

  vip vip0( .clock      (clock),
            .resetn     (resetn),
            .done       (done),
            .dout       (dout),

            .run        (run),
            .din        (din));

  initial begin
    clock   = 1'b0;
    resetn  = 1'b1;
    repeat(2) @(posedge clock);
    resetn  = 1'b0;

    // stimulus is generated in ../../testcase/
  end

  always #10 clock = ~clock;
endmodule
