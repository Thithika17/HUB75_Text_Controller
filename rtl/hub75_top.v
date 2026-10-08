`timescale 1ns / 1ps

module hub75_top (
    input wire clk,
    input wire rst_n,

    input wire [7:0] ascii_in,
    input wire [2:0] char_sel,
    input wire load,

    output wire HUB75_CLK,

    output wire HUB75_A,
    output wire HUB75_B,
    output wire HUB75_C,

    output wire HUB75_LAT,
    output wire HUB75_OE,

    output wire HUB75_R1,
    output wire HUB75_G1,
    output wire HUB75_B1,

    output wire HUB75_R2,
    output wire HUB75_G2,
    output wire HUB75_B2
);

    // =========================================================
    // Internal signals
    // =========================================================

    wire [4:0] pixel_x;
    wire [2:0] row_addr;

    wire shift_en;
    wire latch_en;
    wire display_en;

    wire hub_clk;

    wire pixel_up;
    wire pixel_down;

    // =========================================================
    // HUB75 timing driver
    // =========================================================

    hub75_driver u_scan_ctrl (

        .clk          (clk),
        .rst_n        (rst_n),

        .pixel_count  (pixel_x),
        .row_addr     (row_addr),

        .shift_en     (shift_en),
        .latch_en     (latch_en),
        .display_en   (display_en),

        .hub_clk      (hub_clk)

    );

    // =========================================================
    // Text controller
    // =========================================================

    text_controller u_text_ctrl (

        .clk          (clk),
        .rst_n        (rst_n),

        .ascii_in     (ascii_in),
        .char_sel     (char_sel),
        .load         (load),

        .pixel_x      (pixel_x),
        .row_addr     (row_addr),

        .pixel_up     (pixel_up),
        .pixel_down   (pixel_down)

    );

    // =========================================================
    // HUB75 output mapping
    // =========================================================

    assign HUB75_CLK = hub_clk;

    assign HUB75_A = row_addr[0];
    assign HUB75_B = row_addr[1];
    assign HUB75_C = row_addr[2];

    assign HUB75_LAT = latch_en;

    // HUB75 OE is active LOW
    assign HUB75_OE = ~display_en;

    // Upper half
    assign HUB75_R1 = pixel_up;
    assign HUB75_G1 = pixel_up;
    assign HUB75_B1 = pixel_up;

    // Lower half
    assign HUB75_R2 = pixel_down;
    assign HUB75_G2 = pixel_down;
    assign HUB75_B2 = pixel_down;

endmodule
