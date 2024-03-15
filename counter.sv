// module count number of leds are glowing

module counter
    #(
    parameter LED_NUMBER = 16,                  //Number of leds controlled
    parameter LED_NUMBER_W = $clog2(LED_NUMBER) //Weight of leds.
    )(
    input wire [1:0] led_bhv,   // led behavior of current state
    input wire       div_clk,   // div clock use for controll
    input wire       rst,       // reset signal
    output reg [4:0] count      // count sinal stands for number of leds are glowing
    );
    
    //declare behavior
    localparam INCREASE = 2'b01;
    localparam DESCREASE = 2'b00;
    localparam PASS      = 2'b11;
    
    // declare logic increase and decrease
    logic [LED_NUMBER_W : 0] led_counter_incr;
    logic [LED_NUMBER_W : 0] led_counter_decr;
    
    assign led_counter_decr = count - 1;
    assign led_counter_incr = count + 1;
    
    
    always_ff @(posedge div_clk or posedge rst) begin
        if(rst == 1'b1) begin       // if reset, count set to 0
            count <= 0;
        end
        else begin
            case (led_bhv)
                INCREASE: begin
                    count <= led_counter_incr; // increase number of leds are glowing
                end
                DESCREASE: begin
                    count <= led_counter_decr;  // decrease number of leds are glowing
                end
                PASS: begin
                    count <= count;             // do nothing
                end
            endcase
        end
    end
    
endmodule
