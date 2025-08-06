module N_bit_add #(parameter N = 4) (
    input [N-1:0] a,b,
    output [N-1:0] sum        // change!!
);
    assign sum = a + b;

endmodule