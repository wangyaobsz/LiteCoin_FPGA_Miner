// File name:   hmac_sha256_164.sv
// Created:     07/18/2017
// Author:      Franklin
// Version:     1.0.0
// Description: Module for the 212-Byte input version of HMAC
// data[212] => hash[32]

module hmac_sha256_212 (
    input wire clk,
    input wire n_rst,
    input wire[1695:0] data,
    input wire enable,
    output reg[255:0] hash,
    output reg hash_done
    );

    reg[1055:0] msg;
    wire[255:0] hash1_out;
    wire key_done;
    hmac_sha256_keyhash KEYSHA (.clk(clk),.n_rst(n_rst),.data(data[1695:1056]),.enable(enable),.hash(hash1_out),.hash_done(key_done));
    hmac_sha256_32_132 MAINSHA (.clk(clk),.n_rst(n_rst),.data(hash1_out),.msg(msg),.enable(key_done),.hash(hash),.hash_done(hash_done));

    always_ff @(posedge clk) begin
        if(enable) msg <= data[1055:0];
        else msg <= msg;
    end

endmodule