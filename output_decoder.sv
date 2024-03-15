// decode output from number of leds are glowing

module output_decoder(
    input   [4:0]   count,  // number of leds are glowing
    output  [15:0]  out     // decoded output signal
    );
    
    assign out = (count > 5'd16) ? 0 : 2**count -1; // output will equal to 2^count -1
    
endmodule
