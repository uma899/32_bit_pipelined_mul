`timescale 1ns / 1ps

module tb_32_bit_mul_pipe;

    reg [31: 0] a;
    reg [31: 0] b;
    reg clk;
    reg reset;
    wire [63:0] out;

    mul_pipe_32_bit DUT(
        .a(a),
        .b(b),
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    always #5 clk = ~clk; // Clock period is 10ns

    initial begin
        // Initialize inputs to a known state to avoid 'x'
        a = 32'd0;
        b = 32'd0;
        clk = 0;
        reset = 1;
        #18; 
        reset = 0;

        #10;    
        a = 32'd0;
        b = 32'd0;

        #10;
        a = 32'd25;
        b = 32'd3;

        #10;
        a = 32'd2;
        b = 32'd65;

        #10;
        a = 32'd83;
        b = 32'd4;

        #10;
        a = 32'd5;
        b = 32'd5;

        #10;
        a = 32'd82;
        b = 32'd820;

        #10;
        a = 32'd78945;
        b = 32'd78922;

        #10;  
        a = 32'd0;
        b = 32'd0;

        #10;
        a = 32'd65;
        b = 32'd0;
        #10;

        #100;


        $finish; // Terminate simulation
    end

    // Monitor for output changes at each positive clock edge
    always @(posedge clk) begin
        if (!reset) begin // Only display meaningful data when not in reset
            $display("Time: %0t, Input A: %d, Input B: %d, Output Product: %d", $time, a, b, out);
        end
    end

endmodule