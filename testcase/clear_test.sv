`timescale 1ns/10ps

`include "../tb/sv/macro_file.sv"

module clear_test();
  cpu_tb tb();

  logic [15:0] r0_data = 16'h0;
  logic [15:0] r1_data = 16'h1;
  logic [15:0] r2_data = 16'h2;
  logic [15:0] r3_data = 16'h3;
  logic [15:0] r4_data = 16'h4;
  logic [15:0] r5_data = 16'h5;
  logic [15:0] r6_data = 16'h6;
  logic [15:0] r7_data = 16'h7;

  initial begin
    #5;
    @(negedge tb.resetn);
    @(posedge tb.clock);

    tb.vip0.init_reg(r0_data, r1_data, r2_data, r3_data, r4_data, r5_data, r6_data, r7_data);

    // mv
    tb.vip0.run = 1'b1;
    tb.vip0.din = {3'b000, `R0, `R1};
    @(negedge tb.clock);
    tb.resetn   = 1'b1;
    repeat(3) @(posedge tb.clock);
    tb.resetn   = 1'b0;

    @(posedge tb.clock);
    while(tb.vip0.done != 1) begin
      @(posedge tb.clock);
    end

    // mvi
    tb.vip0.din = {3'b001, `R0, 3'b000};
    @(posedge tb.clock);
    tb.resetn   = 1'b1;
    repeat(3) @(posedge tb.clock);
    tb.resetn   = 1'b0;

    tb.vip0.din = {3'b001, `R0, 3'b000};
    @(posedge tb.clock);
    tb.vip0.din = 16'hf;

    @(posedge tb.clock);
    while(tb.vip0.done != 1) begin
      @(posedge tb.clock);
    end

    // add
    tb.vip0.din = {3'b010, `R2, `R3};
    @(posedge tb.clock);
    tb.resetn   = 1'b1;
    repeat(3) @(posedge tb.clock);
    tb.resetn   = 1'b0;

    @(posedge tb.clock);
    while(tb.vip0.done != 1) begin
      @(posedge tb.clock);
    end

    // sub
    tb.vip0.din = {3'b011, `R7, `R6};
    @(posedge tb.clock);
    tb.resetn   = 1'b1;
    repeat(3) @(posedge tb.clock);
    tb.resetn   = 1'b0;

    @(posedge tb.clock);
    while(tb.vip0.done != 1) begin
      @(posedge tb.clock);
    end
    tb.vip0.run = 1'b0;

    repeat(3) @(posedge tb.clock);
    $finish;
  end
endmodule
