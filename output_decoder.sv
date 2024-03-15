module output_decoder(
    input   [4:0]   count,
    output  [15:0]  out
    );
    
    assign out = (count > 5'd16) ? 0 : 2**count -1;
    
endmodule
