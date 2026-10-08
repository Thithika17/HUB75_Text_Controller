`timescale 1ns / 1ps

module text_controller (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] ascii_in,
    input  wire [2:0] char_sel,
    input  wire       load,

    input  wire [4:0] pixel_x,
    input  wire [2:0] row_addr,

    output reg        pixel_up,
    output reg        pixel_down
);

    // =========================================================
    // 8 character registers
    // 0-3 : upper half
    // 4-7 : lower half
    // =========================================================

    reg [7:0] char_reg [0:7];

    integer i;

    // =========================================================
    // Character register reset and loading
    // =========================================================

    always @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin

            for (i = 0; i < 8; i = i + 1)
                char_reg[i] <= 8'h20;

        end else if (load) begin

            char_reg[char_sel] <= ascii_in;

        end

    end

    // =========================================================
    // Character selection
    // =========================================================

    wire [2:0] char_index;

    assign char_index = pixel_x[4:3];

    // =========================================================
    // Selected characters
    // =========================================================

    wire [7:0] upper_char;
    wire [7:0] lower_char;

    assign upper_char = char_reg[char_index];
    assign lower_char = char_reg[char_index + 3'd4];

    // =========================================================
    // Font ROM outputs
    // =========================================================

    wire [4:0] upper_bitmap;
    wire [4:0] lower_bitmap;

    font_rom upper_font (
        .ascii_code (upper_char),
        .row_addr   (row_addr),
        .row_data   (upper_bitmap)
    );

    font_rom lower_font (
        .ascii_code (lower_char),
        .row_addr   (row_addr),
        .row_data   (lower_bitmap)
    );

    // =========================================================
    // Pixel generation
    //
    // Each character occupies 8 columns:
    // columns 0-4 = 5x7 character
    // columns 5-7 = blank padding
    // =========================================================

    always @(*) begin

        if (pixel_x[2:0] < 3'd5) begin

            pixel_up   = upper_bitmap[4 - pixel_x[2:0]];
            pixel_down = lower_bitmap[4 - pixel_x[2:0]];

        end else begin

            pixel_up   = 1'b0;
            pixel_down = 1'b0;

        end

    end

endmodule
