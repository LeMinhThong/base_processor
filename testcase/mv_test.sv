`timescale 1ns/10ps

`include "../tb/sv/macro_file.sv"

module mv_test();
  cpu_tb tb();

    logic [15:0] r0_data = 16'h0;
    logic [15:0] r1_data = 16'h1;
    logic [15:0] r2_data = 16'h2;
    logic [15:0] r3_data = 16'h3;
    logic [15:0] r4_data = 16'h4;
    logic [15:0] r5_data = 16'h5;
    logic [15:0] r6_data = 16'h6;
    logic [15:0] r7_data = 16'h7;

    logic [2:0] reg_list [8]  = {`R0, `R1, `R2, `R3, `R4, `R5, `R6, `R7};

  initial begin
    #5;
    @(negedge tb.resetn);
    @(posedge tb.clock);

    foreach(reg_list[i]) begin
      $display("init reg: mvi rx x");
      tb.vip0.init_reg(r0_data, r1_data, r2_data, r3_data, r4_data, r5_data, r6_data, r7_data);
      foreach(reg_list[ii]) begin
        $display("mv r%0d r%0d", ii, i);
        tb.vip0.mv(ii, i);
      end
    end

    repeat(5) @(posedge tb.clock);
    $finish;
  end
endmodule
