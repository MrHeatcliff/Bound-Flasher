module bound_flasher(
    input wire clk,
    input wire rst,
    input wire flk,
    output reg [15:0] out
    );
    
    logic div_clk;
    
    clock_divider clock_divider(.clk(clk), .rst(rst), .div_clk(div_clk));
    fsm fsm(.div_clk(div_clk), .flk(flk), .rst(rst), .out(out));
endmodule
