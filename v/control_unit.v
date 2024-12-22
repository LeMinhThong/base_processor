`timescale 1ns/10ps

module control_unit ( // system
                      input             run,
                      input             resetn,
                      // ir
                      input       [8:0] ir,
                      // counter
                      input       [1:0] state,

                      // alu
                      output  reg       ain,
                      output  reg       gin,
                      output  reg       sub,
                      // register
                      output  reg [7:0] rin,
                      // mux
                      output  reg [2:0] rout,
                      output  reg       din_en,
                      output  reg       gout,
                      // ir
                      output  reg       ir_en,
                      // counter
                      output  reg       clear,
                      // system
                      output  reg       done);

  reg [7:0] rx_addr;

  //decoder 3 8
  always @(ir[5:3]) begin
    case(ir[5:3])
      3'b000:   rx_addr = 8'b0000_0001; // r0
      3'b001:   rx_addr = 8'b0000_0010; // r1
      3'b010:   rx_addr = 8'b0000_0100; // r2
      3'b011:   rx_addr = 8'b0000_1000; // r3
      3'b100:   rx_addr = 8'b0001_0000; // r4
      3'b101:   rx_addr = 8'b0010_0000; // r5
      3'b110:   rx_addr = 8'b0100_0000; // r6
      3'b111:   rx_addr = 8'b1000_0000; // r7
    endcase
  end

  always @(run, resetn, state) begin
    if(resetn) begin
      ain     <= 1'b0;
      gin     <= 1'b0;
      sub     <= 1'b0;
      rin     <= 8'b0000_0000;
      rout    <= 3'b000;
      din_en  <= 1'b0;
      ir_en   <= 1'b0;
      clear   <= 1'b1;
      done    <= 1'b0;
    end
    else begin
      if(run) begin
        if(state == 2'b00) begin
          // ir
          ir_en   = 1'b1;
          // register
          rin     = 8'b0000_0000;
          // mux
          rout    = 3'b000;
          din_en  = 1'b0;
          gout    = 1'b0;
          // alu
          ain     = 1'b0;
          gin     = 1'b0;
          sub     = 1'b0;
          // counter
          clear   = 1'b0;
          //system
          done    = 1'b0;
        end
        else begin
          case(ir[8:6])
            3'b000:   begin // mv rx <- ry
                        case(state)
                          2'b01:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = rx_addr;
                                      // mux
                                      rout    = ir[2:0];
                                      din_en  = 1'b0;
                                      gout    = 1'b0;
                                      // alu
                                      ain     = 1'b0;
                                      gin     = 1'b0;
                                      sub     = 1'b0;
                                      // counter
                                      clear   = 1'b1;
                                      //system
                                      done    = 1'b1;
                                    end
                          default:  begin
                                      ain     = ain;
                                      gin     = gin;
                                      sub     = sub;
                                      rin     = rin;
                                      rout    = rout;
                                      din_en  = din_en;
                                      ir_en   = ir_en;
                                      clear   = clear;
                                      done    = done;
                                    end
                        endcase
                      end
            3'b001:   begin // mvi
                        case(state)
                          2'b01:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = rx_addr;
                                      // mux
                                      rout    = 3'b000;
                                      din_en  = 1'b1;
                                      gout    = 1'b0;
                                      // alu
                                      ain     = 1'b0;
                                      gin     = 1'b0;
                                      sub     = 1'b0;
                                      // counter
                                      clear   = 1'b1;
                                      //system
                                      done    = 1'b1;
                                    end
                          default:  begin
                                      ain     = ain;
                                      gin     = gin;
                                      sub     = sub;
                                      rin     = rin;
                                      rout    = rout;
                                      din_en  = din_en;
                                      ir_en   = ir_en;
                                      clear   = clear;
                                      done    = done;
                                    end
                        endcase
                      end
            3'b010:   begin // add
                        case(state)
                          2'b01:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = 8'b0000_0000;
                                      // mux
                                      rout    = ir[5:3];
                                      din_en  = 1'b0;
                                      gout    = 1'b0;
                                      // alu
                                      ain     = 1'b1;
                                      gin     = 1'b0;
                                      sub     = 1'b0;
                                      // counter
                                      clear   = 1'b0;
                                      //system
                                      done    = 1'b0;
                                    end
                          2'b10:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = 8'b0000_0000;
                                      // mux
                                      rout    = ir[2:0];
                                      din_en  = 1'b0;
                                      gout    = 1'b0;
                                      // alu
                                      ain     = 1'b0;
                                      gin     = 1'b1;
                                      sub     = 1'b0;
                                      // counter
                                      clear   = 1'b0;
                                      //system
                                      done    = 1'b0;
                                    end
                          2'b11:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = rx_addr;
                                      // mux
                                      rout    = 3'b000;
                                      din_en  = 1'b0;
                                      gout    = 1'b1;
                                      // alu
                                      ain     = 1'b0;
                                      gin     = 1'b0;
                                      sub     = 1'b0;
                                      // counter
                                      clear   = 1'b1;
                                      //system
                                      done    = 1'b1;
                                    end
                          default:  begin
                                      ain     = ain;
                                      gin     = gin;
                                      sub     = sub;
                                      rin     = rin;
                                      rout    = rout;
                                      din_en  = din_en;
                                      ir_en   = ir_en;
                                      clear   = clear;
                                      done    = done;
                                    end
                        endcase
                      end
            3'b011:   begin // sub
                        case(state)
                          2'b01:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = 8'b0000_0000;
                                      // mux
                                      rout    = ir[5:3];
                                      din_en  = 1'b0;
                                      gout    = 1'b0;
                                      // alu
                                      ain     = 1'b1;
                                      gin     = 1'b0;
                                      sub     = 1'b1;
                                      // counter
                                      clear   = 1'b0;
                                      //system
                                      done    = 1'b0;
                                    end
                          2'b10:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = 8'b0000_0000;
                                      // mux
                                      rout    = ir[2:0];
                                      din_en  = 1'b0;
                                      gout    = 1'b0;
                                      // alu
                                      ain     = 1'b0;
                                      gin     = 1'b1;
                                      sub     = 1'b1;
                                      // counter
                                      clear   = 1'b0;
                                      //system
                                      done    = 1'b0;
                                    end
                          2'b11:    begin
                                      // ir
                                      ir_en   = 1'b0;
                                      // register
                                      rin     = rx_addr;
                                      // mux
                                      rout    = 3'b000;
                                      din_en  = 1'b0;
                                      gout    = 1'b1;
                                      // alu
                                      ain     = 1'b0;
                                      gin     = 1'b0;
                                      sub     = 1'b1;
                                      // counter
                                      clear   = 1'b1;
                                      //system
                                      done    = 1'b1;
                                    end
                          default:  begin
                                      ain     = ain;
                                      gin     = gin;
                                      sub     = sub;
                                      rin     = rin;
                                      rout    = rout;
                                      din_en  = din_en;
                                      ir_en   = ir_en;
                                      clear   = clear;
                                      done    = done;
                                    end
                        endcase
                      end
//            3'b100:   begin // mvo dout <- rx
//                        case(state)
//                          2'b00:    begin
//                                      ain     = 1'b0;
//                                      gin     = 1'b0;
//                                      sub     = 1'b0;
//                                      rin     = rx_addr_de;
//                                      rout    = 3'b000;
//                                      din_en  = 1'b1;
//                                      ir_en   = 1'b0;
//                                      clear   = 1'b0;
//                                      done    = 1'b1;
//                                    end
//                          default:  begin
//                                      ain     = ain;
//                                      gin     = gin;
//                                      sub     = sub;
//                                      rin     = rin;
//                                      rout    = rout;
//                                      din_en  = din_en;
//                                      ir_en   = ir_en;
//                                      clear   = clear;
//                                      done    = done;
//                                    end
//                        endcase
//                      end
          endcase // ir[8:6]
        end
      end
      else begin
        ain     = ain;
        gin     = gin;
        sub     = sub;
        rin     = rin;
        rout    = rout;
        din_en  = din_en;
        ir_en   = ir_en;
        clear   = clear;
        done    = done;
      end
    end
  end
endmodule
