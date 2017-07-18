// File name:   tb_pbkdf2_80_80_128.sv
// Created:     07/18/2017
// Author:      Franklin
// Version:     1.0.0
// Description: test bench for 80-byte pass, 80-byte salt pbkdf2 block

`timescale 1ns / 10ps
module tb_pbkdf2_80_80_128 ();

    localparam CLK_PERIOD = 10;

    reg tb_clk, enable_in, n_rst_in;
    reg[639:0] pass;
    reg[639:0] salt;
    reg[1023:0] data_out;
    reg hash_done;

    pbkdf2_80_80_128 DUT(.clk(tb_clk),.n_rst(n_rst_in),.enable(enable_in),.pass(pass),.salt(salt),.hash(data_out),.hash_done(hash_done));

    // Clock generation block
    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end

    initial begin
        enable_in=0;
        for(integer i=0;i<80;i=i+1) begin
            pass[8*i +: 8] = 8'h01;
        end
        for(integer i=0; i<84;i=i+1) begin
            salt[(8*i) +: 8] = 8'h01;
        end
        n_rst_in=0;
        #(CLK_PERIOD*1.5);
        n_rst_in=1;
        enable_in=1;
        #(CLK_PERIOD);
        enable_in=0;
    end

endmodule