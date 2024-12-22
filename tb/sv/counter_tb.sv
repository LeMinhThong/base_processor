`timescale 1ns/10ps

module counter_tb();
  reg         clock;
  reg         clear;
  
  wire  [1:0] state;

  counter dut(.clock  (clock),
              .clear  (clear),

              .state  (state));

  initial begin
    clear = 1'b1;
    clock = 1'b0;

    repeat(2) @(posedge clock);
    clear = 1'b0;
    repeat(10) begin
      @(posedge clock);
      $display("@%0t [COUNTER] clear: %0b, state: %0b", $time, clear, state);
    end
    $finish;
  end

  always #10 clock = ~clock;
endmodule
