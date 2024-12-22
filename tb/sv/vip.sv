`timescale 1ns/10ps

`include "macro_file.sv"

module vip( input               clock,
            input               resetn,
            input               done,
            input       [15:0]  dout,

            output  reg         run,
            output  reg [15:0]  din);

// ------------------------------------------------------------------

  task init_reg ( input [15:0] r0_data,
                  input [15:0] r1_data,
                  input [15:0] r2_data,
                  input [15:0] r3_data,
                  input [15:0] r4_data,
                  input [15:0] r5_data,
                  input [15:0] r6_data,
                  input [15:0] r7_data);

    logic [2:0]   reg_list  [8];
    logic [15:0]  data_list [8];

    data_list = {r0_data, r1_data, r2_data, r3_data, r4_data, r5_data, r6_data, r7_data};
    reg_list  = {`R0, `R1, `R2, `R3, `R4, `R5, `R6, `R7};

    // mv rx 4'hx
    foreach(reg_list[i]) begin
      $display("mvi r%0d %0h", i, data_list[i]);
      mvi(reg_list[i], data_list[i]);
    end
  endtask

// ------------------------------------------------------------------

  task mv(input [2:0] rx, input [2:0] ry);
    run     = 1'b1;
    din     = {3'b000, rx, ry};

    @(posedge clock);
    while(done != 1) begin
      @(posedge clock);
    end
    run     = 1'b0;
  endtask

// ------------------------------------------------------------------

  task mvi(input [2:0] rx, input [15:0] data);
    run     = 1'b1;
    din     = {3'b001, rx, 3'b000};
    @(posedge clock);
    din     = data;

    @(posedge clock);
    while(done != 1) begin
      @(posedge clock);
    end
    run     = 1'b0;
  endtask

// ------------------------------------------------------------------

  task add(input [2:0] rx, [2:0] ry);
    run     = 1'b1;
    din     = {3'b010, rx, ry};

    @(posedge clock);
    while(done != 1) begin
      @(posedge clock);
    end
    run     = 1'b0;
  endtask

// ------------------------------------------------------------------

  task sub(input [2:0] rx, [2:0] ry);
    run     = 1'b1;
    din     = {3'b011, rx, ry};

    @(posedge clock);
    while(done != 1) begin
      @(posedge clock);
    end
    run     = 1'b0;
  endtask

// ------------------------------------------------------------------

  task mvo(input [2:0] rx);
    run     = 1'b1;
    din     = {3'b100, rx, 3'b000};

    @(posedge clock);
    while(done != 1) begin
      @(posedge clock);
    end
    run     = 1'b0;
  endtask
endmodule
