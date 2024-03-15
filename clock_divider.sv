module clock_divider
 #(
 parameter INTERNAL_CLK         = 125,
 parameter OUTPUT_TIME_FREQ     = 1,
 parameter COUNTER_OUT          = $ceil(INTERNAL_CLK/OUTPUT_TIME_FREQ),
 parameter COUNTER_OUT_W        = $clog2(COUNTER_OUT)
 )(
 input  wire clk,
 input  wire rst,
 output reg div_clk
 );
 // declare for counter reg
 logic [COUNTER_OUT_W - 1 : 0] counter_output;
 logic [COUNTER_OUT_W - 1 : 0] counter_output_load;
 logic [COUNTER_OUT_W - 1 : 0] counter_output_decrease;
 
 //combinational gate for decrease counter
 assign counter_output_load = COUNTER_OUT - 1;
 assign counter_output_decrease = counter_output - 1;
 
 always_ff @(posedge clk) begin
    if(!rst) begin
        counter_output  <= counter_output_load;
        div_clk         <= 0;
    end
    else begin
        if(counter_output == {COUNTER_OUT_W{1'b1}}) begin
            div_clk         <= 1;
            counter_output  <= counter_output_load;
        end
        else begin
            div_clk         <= 0;
            counter_output  <= counter_output_decrease;
        end
    end
    
 end
 
endmodule