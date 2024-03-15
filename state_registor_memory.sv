//flip flop hold next state and active at posedge of div_clock
module state_registor_memory(
    input   wire [2:0]  nxt_st,     // next state will be active
    input   wire        div_clk,    // div_clock signal
    input   wire        rst,        // reset signal
    output  reg    [2:0]cur_st      // cur_state of system
    );
    
    localparam ST_INITIAL = 3'd0;    //declare initial state
    
    always_ff @(posedge div_clk or posedge rst) begin
        if(rst == 1'b1) begin
            cur_st <= ST_INITIAL;   //if reset, cur_st will ben initial
        end
        else begin
            cur_st <= nxt_st;       // curent state will be next state
        end
    end
endmodule
