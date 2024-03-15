module clock_divider
 #(
 parameter INTERNAL_CLK         = 4,
 parameter OUTPUT_TIME_FREQ     = 1,
 parameter COUNTER_OUT          = $rtoi($ceil(INTERNAL_CLK/OUTPUT_TIME_FREQ) - 1),
 parameter COUNTER_OUT_W        = $clog2(COUNTER_OUT)
 )(
 input  wire clk,
 input  wire rst,
 output reg div_clk
 );
 // declare for counter reg
 logic [COUNTER_OUT_W - 1 : 0] counter_output;
 logic [COUNTER_OUT_W - 1 : 0] counter_output_incr;
 
 //combinational gate for decrease counter
 assign counter_output_incr = counter_output + 1;
 
 always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        counter_output  <= 0;
        div_clk         <= 0;
    end
    else begin
        if(counter_output >= COUNTER_OUT) begin
            div_clk         <= 1;
            counter_output  <= 0;
        end
        else begin
            div_clk         <= 0;
            counter_output  <= counter_output_incr;
        end
    end
    
 end
 
endmodule