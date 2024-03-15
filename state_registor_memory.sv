module state_registor_memory(
    input   wire [2:0]  nxt_st,
    input   wire        div_clk,
    input   wire        rst,
    output  reg    [2:0]cur_st
    );
    
    parameter ST_INITIAL = 3'd0;
    
    always_ff @(posedge div_clk or posedge rst) begin
        if(rst) begin
            cur_st <= ST_INITIAL;
        end
        else begin
            cur_st <= nxt_st;
        end
    end
endmodule
