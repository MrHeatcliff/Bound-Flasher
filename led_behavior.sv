module led_behavior(
    input   wire    [2:0]   cur_st,
    output  reg     [1:0]   led_bhv
    );
    
    parameter ST_INITIAL = 3'd0;
    parameter ST_0_TO_15 = 3'd1;
    parameter ST_15_TO_5 = 3'd2;
    parameter ST_5_TO_10 = 3'd3;
    parameter ST_10_TO_0 = 3'd4;
    parameter ST_0_TO_5  = 3'd5;
    parameter ST_5_TO_0  = 3'd6;
    
    always_comb begin
        case(cur_st)
            ST_INITIAL: begin
                led_bhv = 2'd3;
            end
            ST_0_TO_15: begin
                led_bhv = 2'd1;
            end
            ST_15_TO_5: begin
                led_bhv = 2'd0;
            end
            ST_5_TO_10: begin
                led_bhv = 2'd1;
            end
            ST_10_TO_0: begin
                led_bhv = 2'd0;
            end
            ST_0_TO_5: begin
                led_bhv = 2'd1;
            end
            ST_5_TO_0: begin
                led_bhv = 2'd0;
            end
            default: begin
                led_bhv = 2'd3;
            end
        endcase
    end
endmodule
