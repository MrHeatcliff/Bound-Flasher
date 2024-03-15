// Module clock divider
// brief: divide system clock to OUTPUT TIME FREQ
module clock_divider
 #(
 parameter INTERNAL_CLK         = 4,
 parameter OUTPUT_TIME_FREQ     = 1,
 parameter COUNTER_OUT          = $rtoi($ceil(INTERNAL_CLK/OUTPUT_TIME_FREQ) - 1),
 parameter COUNTER_OUT_W        = $clog2(COUNTER_OUT)
 )(
 input  wire clk,       // input: clk: system clock
 input  wire rst,       // input: rst: reset signal, asynchronous
 output reg div_clk     // output: div_clock: divided clock, this is input for module fsm
 );
 // declare for counter reg
 logic [COUNTER_OUT_W - 1 : 0] counter_output;
 logic [COUNTER_OUT_W - 1 : 0] counter_output_incr;
 
 //combinational gate for increase counter
 assign counter_output_incr = counter_output + 1;
 
 //Flip flop for parameterize counter
 always_ff @(posedge clk or posedge rst) begin
    // asynchronous reset
    if(rst == 1'b1) begin
        counter_output  <= 0;
        div_clk         <= 0;
    end
    //Increase counter at posedge of clock signal
    else begin
        if(counter_output >= COUNTER_OUT) begin // overflow, reset counter
            div_clk         <= 1;
            counter_output  <= 0;
        end
        else begin // increase at posedge of clock signal
            div_clk         <= 0;
            counter_output  <= counter_output_incr;
        end
    end
    
 end
 
endmodule