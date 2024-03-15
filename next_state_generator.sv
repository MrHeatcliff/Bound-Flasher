// next_state_generator module will generate next system state and send to
// state registor memory to active at posedge of div_clk.

module next_state_generator(
    input   wire[2:0]      cur_st,  // current state of system
    input   wire[4:0]      count,   // count number of leds are glowing
    input   wire            flk,    // flick signal, control start at initial state and kickback point.
    output  reg [2:0]       nxt_st  // output will be next state of system.
    );
    
    //declare states of system
    localparam ST_INITIAL = 3'd0;
    localparam ST_0_TO_15 = 3'd1;
    localparam ST_15_TO_5 = 3'd2;
    localparam ST_5_TO_10 = 3'd3;
    localparam ST_10_TO_0 = 3'd4;
    localparam ST_0_TO_5  = 3'd5;
    localparam ST_5_TO_0  = 3'd6;
    
    //combinational logic to generate next state based on current state and number of leds are glowing
    always_comb begin
        case (cur_st)
            ST_INITIAL: begin                           //initial state
                if(flk == 1) nxt_st = ST_0_TO_15;       // if we have flk signal, system will transfer to state 0 to 15
                else nxt_st = cur_st;                   // else we stay at initial state
            end
            ST_0_TO_15: begin                           // state will turn on leds gradualy 0 to 15
                if(count == 5'd15) nxt_st = ST_15_TO_5; // if led 15 turn on, move to state 15 to 5
                else nxt_st = cur_st;                   //else stay at current state.
            end
            ST_15_TO_5: begin                                           // state will turn off leds gradually from 15 to 5
                if(flk == 1 && count == 5'd6) nxt_st = ST_0_TO_15;      // if when led 5 is off and flick = 1, we go back to state 0 to 15
                else if(count == 5'd6) nxt_st = ST_5_TO_10;             // if led 5 is off and flick = 0, move to state 5 to 10
                else nxt_st = cur_st;                   // else stay at current state
            end
            ST_5_TO_10: begin                           // state will turn on leds gradually from 5 to 10
                if(count == 5'd10) nxt_st = ST_10_TO_0; // when led 10 is glowing, move to state 10 to 0
                else nxt_st = cur_st;                   //else stay at current state.
            end
            ST_10_TO_0: begin                           // state will turn off leds gradually from 10 to 0
                if(((count == 5'd6)||(count == 5'd1))&&(flk == 1)) nxt_st = ST_5_TO_10;     // if led 5 or led 0 off when flick = 1, go back to state 5 to 10
                else if ((count == 5'd1)&&(flk == 0)) nxt_st = ST_0_TO_5;                   // if led 0 off and flick = 0, go to state 0 to 5
                else nxt_st = cur_st;                   // else stay at current state
            end
            ST_0_TO_5: begin                            // state will turn on leds gradually from 0 to 5
                if(count == 5'd5) nxt_st = ST_5_TO_0;   // when led 5 on, move to state 5 to 0
                else nxt_st = cur_st;                   // else stay at current state
            end
            ST_5_TO_0: begin                            // state will turn off leds gradually from 5 to 0
                if(count == 5'd1) nxt_st = ST_INITIAL;  // this state will not have kickback poin, so when led 0 if off, move to initial state
                else nxt_st = cur_st;                   // else stay at current state
            end
            default: begin 
                nxt_st = ST_INITIAL;                    // default, system will be at initial state
            end
        endcase
    end
    
endmodule
