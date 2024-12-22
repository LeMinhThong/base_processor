`timescale 1ns/10ps

`include "../tb/sv/macro_file.sv"

module control_unit_tb();
  reg         run;
  reg         resetn;
  reg   [8:0] ir;
  reg   [1:0] state;

  wire        ain;
  wire        gin;
  wire        sub;
  wire  [7:0] rin;
  wire  [2:0] rout;
  wire        din_en;
  wire        gout;
  wire        ir_en;
  wire        clear;
  wire        done;

  control_unit cu ( .run    (run),
                    .resetn (resetn),
                    .ir     (ir),
                    .state  (state),

                    .ain    (ain),
                    .gin    (gin),
                    .sub    (sub),
                    .rin    (rin),
                    .rout   (rout),
                    .din_en (din_en),
                    .gout   (gout),
                    .ir_en  (ir_en),
                    .clear  (clear),
                    .done   (done));

  initial begin
    run       = 1'b0;
    resetn    = 1'b1;
    ir        = 9'h0;
    state     = 3'h0;
  end

  initial begin
    #10;
    resetn  = 1'b0;
    // mv R2 R0
        run     = 1'b1;
        ir      = 9'b000_010_000;
        state   = 2'b00;
    #10 state   = 2'b01;
    #10 state   = 2'b10;
    #10 state   = 2'b11;
    #10;

    // mvi R1
        run     = 1'b1;
        ir      = 9'b001_001_000;
        state   = 2'b00;
    #10 state   = 2'b01;
    #10 state   = 2'b10;
    #10 state   = 2'b11;
    #10;

    // add R2 R3
        run     = 1'b1;
        ir      = 9'b010_010_011;
        state   = 2'b00;
    #10 state   = 2'b01;
    #10 state   = 2'b10;
    #10 state   = 2'b11;
    #10;

    // sub R4 r5
        run     = 1'b1;
        ir      = 9'b011_100_101;
        state   = 2'b00;
    #10 state   = 2'b01;
    #10 state   = 2'b10;
    #10 state   = 2'b11;
    #10;

    #30 $finish;
  end

endmodule
