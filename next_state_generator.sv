module next_state_generator(
    input   wire[2:0]      cur_st,
    input   wire[4:0]      count,
    input   wire            flk,
    output  reg [2:0]       nxt_st
    );
    
    parameter ST_INITIAL = 3'd0;
    parameter ST_0_TO_15 = 3'd1;
    parameter ST_15_TO_5 = 3'd2;
    parameter ST_5_TO_10 = 3'd3;
    parameter ST_10_TO_0 = 3'd4;
    parameter ST_0_TO_5  = 3'd5;
    parameter ST_5_TO_0  = 3'd6;
    
    always_comb begin
        case (cur_st)
            ST_INITIAL: begin
                if(flk == 1) nxt_st = ST_0_TO_15;
                else nxt_st = cur_st;
            end
            ST_0_TO_15: begin
                if(count == 5'd15) nxt_st = ST_15_TO_5;
                else nxt_st = cur_st;
            end
            ST_15_TO_5: begin
                if(flk == 1 && count == 5'd6) nxt_st = ST_0_TO_15;
                else if(count == 5'd6) nxt_st = ST_5_TO_10;
                else nxt_st = cur_st;
            end
            ST_5_TO_10: begin
                if(count == 5'd10) nxt_st = ST_10_TO_0;
                else nxt_st = cur_st;
            end
            ST_10_TO_0: begin
                if(((count == 5'd6)||(count == 5'd1))&&(flk == 1)) nxt_st = ST_5_TO_10;
                else if ((count == 5'd1)&&(flk == 0)) nxt_st = ST_0_TO_5;
                else nxt_st = cur_st;
            end
            ST_0_TO_5: begin
                if(count == 5'd5) nxt_st = ST_5_TO_0;
                else nxt_st = cur_st;
            end
            ST_5_TO_0: begin
                if(count == 5'd1) nxt_st = ST_INITIAL;
                else nxt_st = cur_st;
            end
            default: begin
                nxt_st = ST_INITIAL;
            end
        endcase
    end
    
endmodule
