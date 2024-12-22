`timescale 1ns/10ps

module cpu( input         clock,
            input         resetn,
            input         run,
            input [15:0]  din,

            output        done);

  wire  [15:0]  buswires;
  wire  [7:0]   rin;
  wire          ir_en;
  wire  [15:0]  r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out;
  wire  [8:0]   ir_out;

  wire          ain;
  wire          gin;
  wire          sub;
  wire  [15:0]  aluout;

  wire  [2:0]   rout;
  wire          din_en;
  wire          gout;

  wire  [1:0]   state;
  wire          clear_state;

  // r0 -> r7 register
  register #(.WIDTH (16))  r0 ( .clock (clock), .rin (rin[0]), .buswires (buswires), .r (r0_out));
  register #(.WIDTH (16))  r1 ( .clock (clock), .rin (rin[1]), .buswires (buswires), .r (r1_out));
  register #(.WIDTH (16))  r2 ( .clock (clock), .rin (rin[2]), .buswires (buswires), .r (r2_out));
  register #(.WIDTH (16))  r3 ( .clock (clock), .rin (rin[3]), .buswires (buswires), .r (r3_out));
  register #(.WIDTH (16))  r4 ( .clock (clock), .rin (rin[4]), .buswires (buswires), .r (r4_out));
  register #(.WIDTH (16))  r5 ( .clock (clock), .rin (rin[5]), .buswires (buswires), .r (r5_out));
  register #(.WIDTH (16))  r6 ( .clock (clock), .rin (rin[6]), .buswires (buswires), .r (r6_out));
  register #(.WIDTH (16))  r7 ( .clock (clock), .rin (rin[7]), .buswires (buswires), .r (r7_out));

  // ir register
  register #(.WIDTH (9))  ir ( .clock (clock), .rin (ir_en), .buswires (din[8:0]), .r (ir_out));

  // alu
  alu alu0( .clock    (clock),
            .ain      (ain),
            .gin      (gin),
            .sub      (sub),
            .buswires (buswires),

            .aluout   (aluout));

  // mux
  multiplexers mux( .rout   (rout),
                    .din_en (din_en),
                    .gout   (gout),
                    .r0     (r0_out),
                    .r1     (r1_out),
                    .r2     (r2_out),
                    .r3     (r3_out),
                    .r4     (r4_out),
                    .r5     (r5_out),
                    .r6     (r6_out),
                    .r7     (r7_out),
                    .din    (din),
                    .aluout (aluout),
                    
                    .buswires (buswires));

  // control_unit
  control_unit cu ( .run      (run),
                    .resetn   (resetn),
                    .ir       (ir_out),
                    .state    (state),

                    .ain      (ain),
                    .gin      (gin),
                    .sub      (sub),
                    .rin      (rin),
                    .rout     (rout),
                    .din_en   (din_en),
                    .gout     (gout),
                    .ir_en    (ir_en),
                    .clear    (clear_state),
                    .done     (done));

  // counter
  counter counter0( .clock  (clock),
                    .clear  (clear_state),
                    
                    .state  (state));
endmodule
