//fsm module
// brief: this module use divided clock and control the system state and output 
module fsm(
    input wire div_clk,     // input: div_clk: divided clock from clock divider module
    input wire flk,         // input: flk: flick signal, use for control system at kick back point (led[5] and led[0])
    input wire rst,         // intput: rst: reset signal, reset system to initial state, reset registor to 0.
    output reg [15:0] out   // output: [15:0] out: output signal, used to control 16 leds output.
    );
    
    // declare internal signal between modules.
    logic [2:0] cur_st;     // current state of system, input of next_state_generator module and led_behavior module.
    logic [4:0] count;      // count number of leds is glowing. Use for generate next state and decode the output.
    logic [2:0] nxt_st;     // next state of system, will be active at posedge of div_clk signal.
    logic [1:0] led_bhv;    // led behavior of current state, it will control if the leds will turn on, off or do nothing.
    
    next_state_generator next_state_generator(.cur_st(cur_st), .count(count), .flk(flk), .nxt_st(nxt_st));
    state_registor_memory state_registor_memory (.nxt_st(nxt_st), .div_clk(div_clk), .rst(rst), .cur_st(cur_st));
    led_behavior led_behavior(.cur_st(cur_st), .led_bhv(led_bhv));
    counter counter(.led_bhv(led_bhv), .div_clk(div_clk), .rst(rst), .count(count));
    output_decoder output_decoder(.count(count), .out(out));
endmodule
