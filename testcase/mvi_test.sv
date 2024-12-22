`timescale 1ns/10ps

`include "../tb/sv/macro_file.sv"

module mvi_test();

  cpu_tb tb();

  logic [2:0] reg_list [8] = {`R0, `R1, `R2, `R3, `R4, `R5, `R6, `R7};

  initial begin
    #5;
    @(negedge tb.resetn);

    @(posedge tb.clock);

    // mv rx 4'hx
    foreach(reg_list[i]) begin
      $display("mvi r%0d %0h", i, i);
      
      @(posedge tb.clock);
      tb.vip0.mvi(reg_list[i], i);
  
      @(posedge tb.clock);
      while(tb.cpu0.done != 1) begin
        @(posedge tb.clock);
      end
    end

    // mv rx 8'hx0
    foreach(reg_list[i]) begin
      $display("mvi r%0d %0h", i, i+8'hf0);
      
      @(posedge tb.clock);
      tb.vip0.mvi(reg_list[i], i+8'hf0);
  
      @(posedge tb.clock);
      while(tb.cpu0.done != 1) begin
        @(posedge tb.clock);
      end
    end

    repeat(5) @(posedge tb.clock);
    $finish;
  end
endmodule
