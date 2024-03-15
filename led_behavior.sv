// module control behavior of led based on current state.

module led_behavior(
    input   wire    [2:0]   cur_st, // curent state signal, get from state registor memory
    output  reg     [1:0]   led_bhv // led behavior of current state
    );
    
    // declare state
    localparam ST_INITIAL = 3'd0;
    localparam ST_0_TO_15 = 3'd1;
    localparam ST_15_TO_5 = 3'd2;
    localparam ST_5_TO_10 = 3'd3;
    localparam ST_10_TO_0 = 3'd4;
    localparam ST_0_TO_5  = 3'd5;
    localparam ST_5_TO_0  = 3'd6;
    
    
    // led will be turn on gradually at state 0to15, 5to10, 0to5
    // led will be turn off gradually at state 15to5, 10to0, 5to0
    // led will be do nothing at state initial
    always_comb begin
        case(cur_st)
            ST_INITIAL:
                led_bhv = 2'd3;
            ST_0_TO_15, ST_0_TO_5, ST_5_TO_10:
                led_bhv = 2'd1;
            ST_15_TO_5, ST_10_TO_0, ST_5_TO_0: 
                led_bhv = 2'd0;
            default:
                led_bhv = 2'd3;
        endcase
    end
endmodule
