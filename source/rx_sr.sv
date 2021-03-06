// File name:   rx_sr.sv
// Created:     07/18/2017
// Author:      Franklin
// Version:     1.0.0
// Description: Receiver shift register.

module rx_sr (
    input wire clk,
    input wire n_rst,
    input wire sda_in,
    input wire rising_edge_found,
    input wire rx_enable,
    output wire [7:0] rx_data
    );

wire shift_enable;

assign shift_enable = rx_enable & rising_edge_found;

flex_stp_sr #(.NUM_BITS(8), .SHIFT_MSB(1)) RX_SHIFT_REG
(
    .clk(clk),
    .n_rst(n_rst),
    .shift_enable(shift_enable),
    .serial_in(sda_in),
    .parallel_out(rx_data)
);

endmodule