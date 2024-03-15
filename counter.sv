module counter
    #(
    parameter LED_NUMBER = 16,
    parameter LED_NUMBER_W = $clog2(LED_NUMBER)
    )(
    input wire [1:0] led_bhv,
    input wire       div_clk,
    input wire       rst,
    output reg [4:0] count
    );
    
    localparam INCREASE = 2'b01;
    localparam DESCREASE = 2'b00;
    localparam PASS      = 2'b11;
    
    logic [LED_NUMBER_W : 0] led_counter_incr;
    logic [LED_NUMBER_W : 0] led_counter_decr;
    
    assign led_counter_decr = count - 1;
    assign led_counter_incr = count + 1;
    
    
    always_ff @(posedge div_clk or posedge rst) begin
        if(rst) begin
            count <= 0;
        end
        else begin
            case (led_bhv)
                INCREASE: begin
                    count <= led_counter_incr;
                end
                DESCREASE: begin
                    count <= led_counter_decr;
                end
                PASS: begin
                    count <= count;
                end
            endcase
        end
    end
    
endmodule
