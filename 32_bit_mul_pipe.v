module mul_pipe_32_bit (
    input [31: 0] a,
    input [31: 0] b,
    input clk, reset,
    output [63:0] out
);


    wire [31: 0] A;
    wire [31: 0] B;

    
    wire [63:0] partial_products_in [31:0];
    /* s1 reg */
    wire [63:0] partial_products_out [31:0];
    /* into s2 add */
    wire [63:0] partial_addition1_out [15:0];
    /* s2 reg */
    wire [63:0] partial_addition2_in [15:0];
    /* into s3 add */
    wire [63:0] partial_addition2_out [7:0];
    /* s3 reg */
    wire [63:0] partial_addition3_in [7:0];
    /* into s4 add */
    wire [63:0] partial_addition3_out [3:0];
    /* s4 reg */
    wire [63:0] partial_addition4_in [3:0];
    /* into s5 add */
    wire [63:0] partial_addition4_out [1:0];
    /* s5 reg */
    wire [63:0] partial_addition5_in [1:0];
    /* into s6 add */
    wire [63:0] partial_addition5_out;
    /* s6 reg */


    genvar k;
    genvar j;


/* Stage 0  start */
    stage_register #(.N(32)) s1_A(
        .data_in(a),
        .clk(clk), .reset(reset),
        .data_out(A)
    );
    stage_register #(.N(32)) s1_B(
        .data_in(b),
        .clk(clk), .reset(reset),
        .data_out(B)
    );
/* Stage 0 end */    




/* Stage 1 start */
    generate
        for(k=0; k<32; k = k + 1) begin
            two_one_mux #(.shift(k)) mux1(
                .A(A),
                .B(B[k]),
                .out(partial_products_in[k])
            );

            stage_register #(.N(64)) pp_reg(
                .data_in(partial_products_in[k]),
                .clk(clk), .reset(reset),
                .data_out(partial_products_out[k])
            );
        end          
    endgenerate   
/* Stage 2 end */     


/* Stage 3 start */
    generate
        for (j = 0; j < 16; j = j + 1) begin
            CLA_add #(.N(64)) addr1 (
                .A(partial_products_out[2*j]),
                .B(partial_products_out[(2*j)+1]),
                .clk(clk), .reset(reset),
                .sum(partial_addition1_out[j])
            );
        end
    endgenerate 
    generate
        for(k=0; k<16; k = k + 1) begin
            stage_register #(.N(64)) s2(
                .data_in(partial_addition1_out[k]),
                .clk(clk), .reset(reset),
                .data_out(partial_addition2_in[k])
            );
        end          
    endgenerate
/* Stage 3 end */

/* Stage 4 start */
    generate
        for (j = 0; j < 8; j = j + 1) begin
            CLA_add #(.N(64)) addr1 (
                .A(partial_addition2_in[2*j]),
                .B(partial_addition2_in[(2*j)+1]),
                .clk(clk), .reset(reset),
                .sum(partial_addition2_out[j])
            );
        end
    endgenerate     

    generate
        for(k=0; k<8; k = k + 1) begin
            stage_register #(.N(64)) s3(
                .data_in(partial_addition2_out[k]),
                .clk(clk), .reset(reset),
                .data_out(partial_addition3_in[k])
            );
        end          
    endgenerate
/* Stage 4 end */    


/* Stage 5 start */
    generate
        for (j = 0; j < 4; j = j + 1) begin
            CLA_add #(.N(64)) addr1 (
                .A(partial_addition3_in[2*j]),
                .B(partial_addition3_in[(2*j)+1]),
                .clk(clk), .reset(reset),
                .sum(partial_addition3_out[j])
            );
        end
    endgenerate   
    generate
        for(k=0; k<4; k = k + 1) begin
            stage_register #(.N(64)) s4(
                .data_in(partial_addition3_out[k]),
                .clk(clk), .reset(reset),
                .data_out(partial_addition4_in[k])
            );
        end          
    endgenerate
/* Stage 5 end */    

/* Stage 6 start */
    generate
        for (j = 0; j < 2; j = j + 1) begin
            CLA_add #(.N(64)) addr1 (
                .A(partial_addition4_in[2*j]),
                .B(partial_addition4_in[(2*j)+1]),
                .clk(clk), .reset(reset),
                .sum(partial_addition4_out[j])
            );
        end
    endgenerate      

    generate
        for(k=0; k<2; k = k + 1) begin
            stage_register #(.N(64)) s4(
                .data_in(partial_addition4_out[k]),
                .clk(clk), .reset(reset),
                .data_out(partial_addition5_in[k])
            );
        end          
    endgenerate    
/* Stage 6 end */   



    CLA_add #(.N(64)) addr1 (
        .A(partial_addition5_in[0]),
        .B(partial_addition5_in[1]),
        .clk(clk), .reset(reset),
        .sum(partial_addition5_out)
    );    

    stage_register #(.N(64)) s_last(
        .data_in(partial_addition5_out),
        .clk(clk), .reset(reset),
        .data_out(out)
    );   

endmodule