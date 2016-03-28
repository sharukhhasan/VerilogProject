// ECE:3350 SISC computer project
// finite state machine

`timescale 1ns/100ps

module ctrl (clk, rst_f, opcode, mm, stat, rf_we, alu_op, wb_sel, rd_sel);
  
  /* TODO: Declare the ports listed above as inputs or outputs */
  input clk, rst_f;
  input [3:0] opcode, mm, stat;
  output reg rf_we, wb_sel, rd_sel;
  output reg [1:0] alu_op;
  
  // states
  parameter start0 = 0, start1 = 1, fetch = 2, decode = 3, execute = 4, mem = 5, writeback = 6;
   
  // opcodes
  parameter NOOP = 0, LOD = 1, STR = 2, ALU_OP = 8, BRA = 4, BRR = 5, BNE = 6, HLT=15;
	
  // addressing modes
  parameter am_imm = 8;

  // state registers
  reg [2:0]  present_state, next_state;

  /* TODO: Write a clock process that progresses the fsm to the next state on the
       positive edge of the clock, OR resets the state to 'start0' on the negative edge
       of rst_f. Notice that the computer is reset when rst_f is low, not high. */
  always @(posedge clk or negedge rst_f)
  begin
  	if (!rst_f) begin
  	  present_state <= start0;
    end
    else begin
	  present_state <= next_state;
    end
  end


  /* TODO: Write a process that determines the next state of the fsm. */
  always @(present_state)
  begin
  	case (present_state)
  	  start0:    next_state <= start1;
      start1:    next_state <= decode;
      fetch:     next_state <= decode;     
      decode:    next_state <= execute;
      execute:   next_state <= mem;
      mem:       next_state <= writeback;
      writeback: next_state <= fetch;     
    endcase
  end

  // Halt on HLT instruction
  always @ (opcode)
  begin
    if (opcode == HLT)
    begin 
      #1 $display ("Halt."); //Delay 1 ns so $monitor will print the halt instruction
      $stop;
    end
  end
    
  /* TODO: Generate outputs based on the FSM states and inputs. For Parts 2 and 3, you will
       add the new control signals here. */

  // fetch
    
  // decode

  // execute
    
  // mem
    
  // write back

endmodule