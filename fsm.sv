module fsm(
    input wire div_clk,
    input wire flk,
    input wire rst,
    output reg [15:0] out
    );
    
    logic [2:0] cur_st;
    logic [4:0] count;
    logic [2:0] nxt_st;
    logic [1:0] led_bhv;
    
    next_state_generator next_state_generator(.cur_st(cur_st), .count(count), .flk(flk), .nxt_st(nxt_st));
    state_registor_memory state_registor_memory (.nxt_st(nxt_st), .div_clk(div_clk), .rst(rst), .cur_st(cur_st));
    led_behavior led_behavior(.cur_st(cur_st), .led_bhv(led_bhv));
    counter counter(.led_bhv(led_bhv), .div_clk(div_clk), .rst(rst), .count(count));
    output_decoder output_decoder(.count(count), .out(out));
endmodule
