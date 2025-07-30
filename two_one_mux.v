module two_one_mux #(parameter shift = 0)(
    input [31:0] A,
    input B,
    output [63:0] out
);

    wire [31:0] pp;
    assign pp = (B == 1) ? A : 32'b0;
    assign out = pp << shift;


endmodule