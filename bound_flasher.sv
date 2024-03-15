//Module bound_flasher, this is combi by 2 main module, clock divider and fsm.

module bound_flasher(
    input wire clk, // fpga clock signal
    input wire rst, // reset signal
    input wire flk, // flick signal
    output reg [15:0] out // 16 bit output to control 16 leds
    );
    
    logic div_clk; // internal signal from clock_divider to fsm.
    
    clock_divider clock_divider(.clk(clk), .rst(rst), .div_clk(div_clk));
    fsm fsm(.div_clk(div_clk), .flk(flk), .rst(rst), .out(out));
endmodule
