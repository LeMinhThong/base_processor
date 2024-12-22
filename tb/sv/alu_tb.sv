`timescale 1ns/10ps

module alu_tb();
  reg           clock;
  reg           ain;
  reg           gin;
  reg           sub;
  reg   [15:0]  buswires;

  wire  [15:0]  aluout;

  logic [15:0] a, b, result;

  alu alu0  ( .clock      (clock),
              .ain        (ain),
              .gin        (gin),
              .sub        (sub),
              .buswires   (buswires),

              .aluout     (aluout));

  initial begin
    clock     = 0;
    ain       = 0;
    gin       = 0;
    sub       = 0;
    buswires  = 0;
  end

  initial begin
    @(negedge clock);
    for(int i=0; i<=1; i++) begin
      repeat(5) begin
        @(posedge clock);
        ain       = 1;
        gin       = 0;
        sub       = i;
        a         = $urandom();
        buswires  = a;

        @(posedge clock);
        ain       = 0;
        gin       = 1;
        sub       = i;
        b         = $urandom();
        buswires  = b;

        @(posedge clock);
        #1 result = aluout;

        if(sub) begin
          if(a - b == result) begin
            $display("@%0t [SUB_PASS] a: %0h, b: %0h, result: %0h", $time, a, b, result);
          end
          else begin
            $display("@%0t [SUB_FAIL] a: %0h, b: %0h, result: %0h", $time, a, b, result);
          end
        end else begin
          if(a + b == result) begin
            $display("@%0t [ADD_PASS] a: %0h, b: %0h, result: %0h", $time, a, b, result);
          end
          else begin
            $display("@%0t [ADD_FAIL] a: %0h, b: %0h, result: %0h", $time, a, b, result);
          end
        end
      end
    end
    $finish;
  end

  always #10 clock = ~clock;
endmodule

