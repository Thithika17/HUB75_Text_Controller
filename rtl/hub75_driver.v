`timescale 1ns / 1ps

module hub75_driver(
    input  wire clk,
    input  wire rst_n,

    output reg [4:0] pixel_count,
    output reg [2:0] row_addr,

    output reg shift_en,
    output reg latch_en,
    output reg display_en,

    output reg hub_clk
);

    localparam integer CLK_HALF_CYCLES = 200;
    localparam integer LAT_CYCLES      = 100;
    localparam integer DISPLAY_CYCLES  = 20000;

    localparam [1:0]
        SHIFT   = 2'd0,
        LATCH   = 2'd1,
        DISPLAY = 2'd2;

    reg [1:0] state;

    reg [8:0]  clk_count;
    reg [6:0]  lat_count;
    reg [14:0] display_count;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state         <= SHIFT;
            pixel_count   <= 5'd0;
            row_addr      <= 3'd0;
            clk_count     <= 9'd0;
            lat_count     <= 7'd0;
            display_count <= 15'd0;
            hub_clk       <= 1'b0;
        end else begin
            case (state)

                SHIFT: begin
                    lat_count     <= 7'd0;
                    display_count <= 15'd0;

                    if (clk_count == CLK_HALF_CYCLES - 1) begin
                        clk_count <= 9'd0;
                        hub_clk <= ~hub_clk;

                        if (hub_clk == 1'b1) begin

                            if (pixel_count == 5'd31) begin
                                pixel_count <= 5'd0;
                                state <= LATCH;
                                hub_clk <= 1'b0;
                            end else begin
                                pixel_count <= pixel_count + 1'b1;
                            end

                        end
                    end else begin
                        clk_count <= clk_count + 1'b1;
                    end
                end

                LATCH: begin
                    hub_clk <= 1'b0;
                    clk_count     <= 9'd0;
                    display_count <= 15'd0;

                    if (lat_count == LAT_CYCLES - 1) begin
                        lat_count <= 7'd0;
                        state <= DISPLAY;
                    end else begin
                        lat_count <= lat_count + 1'b1;
                    end
                end

                DISPLAY: begin
                    hub_clk <= 1'b0;
                    clk_count <= 9'd0;
                    lat_count <= 7'd0;

                    if (display_count == DISPLAY_CYCLES - 1) begin
                        display_count <= 15'd0;

                        if (row_addr == 3'd7)
                            row_addr <= 3'd0;
                        else
                            row_addr <= row_addr + 1'b1;

                        state <= SHIFT;
                    end else begin
                        display_count <= display_count + 1'b1;
                    end
                end

                default: begin
                    state         <= SHIFT;
                    pixel_count   <= 5'd0;
                    row_addr      <= 3'd0;
                    clk_count     <= 9'd0;
                    lat_count     <= 7'd0;
                    display_count <= 15'd0;
                    hub_clk       <= 1'b0;
                end

            endcase
        end
    end

    always @(*) begin

        shift_en   = 1'b0;
        latch_en   = 1'b0;
        display_en = 1'b0;

        case (state)

            SHIFT:
                shift_en = 1'b1;

            LATCH:
                latch_en = 1'b1;

            DISPLAY:
                display_en = 1'b1;

            default: begin
                shift_en   = 1'b0;
                latch_en   = 1'b0;
                display_en = 1'b0;
            end

        endcase
    end

endmodule

