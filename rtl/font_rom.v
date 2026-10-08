`timescale 1ns / 1ps

module font_rom (
    input  wire [7:0] ascii_code,
    input  wire [2:0] row_addr,
    output reg  [4:0] row_data
);

    always @(*) begin

        case (ascii_code)

            // A
            8'h41: begin
                case (row_addr)
                    3'd0: row_data = 5'b01110;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b11111;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // B
            8'h42: begin
                case (row_addr)
                    3'd0: row_data = 5'b11110;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b11110;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b11110;
                    default: row_data = 5'b00000;
                endcase
            end

            // C
            8'h43: begin
                case (row_addr)
                    3'd0: row_data = 5'b01111;
                    3'd1: row_data = 5'b10000;
                    3'd2: row_data = 5'b10000;
                    3'd3: row_data = 5'b10000;
                    3'd4: row_data = 5'b10000;
                    3'd5: row_data = 5'b10000;
                    3'd6: row_data = 5'b01111;
                    default: row_data = 5'b00000;
                endcase
            end

            // D
            8'h44: begin
                case (row_addr)
                    3'd0: row_data = 5'b11110;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b10001;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b11110;
                    default: row_data = 5'b00000;
                endcase
            end

            // E
            8'h45: begin
                case (row_addr)
                    3'd0: row_data = 5'b11111;
                    3'd1: row_data = 5'b10000;
                    3'd2: row_data = 5'b10000;
                    3'd3: row_data = 5'b11110;
                    3'd4: row_data = 5'b10000;
                    3'd5: row_data = 5'b10000;
                    3'd6: row_data = 5'b11111;
                    default: row_data = 5'b00000;
                endcase
            end

            // F
            8'h46: begin
                case (row_addr)
                    3'd0: row_data = 5'b11111;
                    3'd1: row_data = 5'b10000;
                    3'd2: row_data = 5'b10000;
                    3'd3: row_data = 5'b11110;
                    3'd4: row_data = 5'b10000;
                    3'd5: row_data = 5'b10000;
                    3'd6: row_data = 5'b10000;
                    default: row_data = 5'b00000;
                endcase
            end

            // G
            8'h47: begin
                case (row_addr)
                    3'd0: row_data = 5'b01111;
                    3'd1: row_data = 5'b10000;
                    3'd2: row_data = 5'b10000;
                    3'd3: row_data = 5'b10111;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b01111;
                    default: row_data = 5'b00000;
                endcase
            end

            // H
            8'h48: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b11111;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // I
            8'h49: begin
                case (row_addr)
                    3'd0: row_data = 5'b11111;
                    3'd1: row_data = 5'b00100;
                    3'd2: row_data = 5'b00100;
                    3'd3: row_data = 5'b00100;
                    3'd4: row_data = 5'b00100;
                    3'd5: row_data = 5'b00100;
                    3'd6: row_data = 5'b11111;
                    default: row_data = 5'b00000;
                endcase
            end

            // J
            8'h4A: begin
                case (row_addr)
                    3'd0: row_data = 5'b00111;
                    3'd1: row_data = 5'b00010;
                    3'd2: row_data = 5'b00010;
                    3'd3: row_data = 5'b00010;
                    3'd4: row_data = 5'b10010;
                    3'd5: row_data = 5'b10010;
                    3'd6: row_data = 5'b01100;
                    default: row_data = 5'b00000;
                endcase
            end

            // K
            8'h4B: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b10010;
                    3'd2: row_data = 5'b10100;
                    3'd3: row_data = 5'b11000;
                    3'd4: row_data = 5'b10100;
                    3'd5: row_data = 5'b10010;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // L
            8'h4C: begin
                case (row_addr)
                    3'd0: row_data = 5'b10000;
                    3'd1: row_data = 5'b10000;
                    3'd2: row_data = 5'b10000;
                    3'd3: row_data = 5'b10000;
                    3'd4: row_data = 5'b10000;
                    3'd5: row_data = 5'b10000;
                    3'd6: row_data = 5'b11111;
                    default: row_data = 5'b00000;
                endcase
            end

            // M
            8'h4D: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b11011;
                    3'd2: row_data = 5'b10101;
                    3'd3: row_data = 5'b10101;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // N
            8'h4E: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b11001;
                    3'd2: row_data = 5'b10101;
                    3'd3: row_data = 5'b10011;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // O
            8'h4F: begin
                case (row_addr)
                    3'd0: row_data = 5'b01110;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b10001;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b01110;
                    default: row_data = 5'b00000;
                endcase
            end

            // P
            8'h50: begin
                case (row_addr)
                    3'd0: row_data = 5'b11110;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b11110;
                    3'd4: row_data = 5'b10000;
                    3'd5: row_data = 5'b10000;
                    3'd6: row_data = 5'b10000;
                    default: row_data = 5'b00000;
                endcase
            end

            // Q
            8'h51: begin
                case (row_addr)
                    3'd0: row_data = 5'b01110;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b10001;
                    3'd4: row_data = 5'b10101;
                    3'd5: row_data = 5'b10010;
                    3'd6: row_data = 5'b01101;
                    default: row_data = 5'b00000;
                endcase
            end

            // R
            8'h52: begin
                case (row_addr)
                    3'd0: row_data = 5'b11110;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b11110;
                    3'd4: row_data = 5'b10100;
                    3'd5: row_data = 5'b10010;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // S
            8'h53: begin
                case (row_addr)
                    3'd0: row_data = 5'b01111;
                    3'd1: row_data = 5'b10000;
                    3'd2: row_data = 5'b10000;
                    3'd3: row_data = 5'b01110;
                    3'd4: row_data = 5'b00001;
                    3'd5: row_data = 5'b00001;
                    3'd6: row_data = 5'b11110;
                    default: row_data = 5'b00000;
                endcase
            end

            // T
            8'h54: begin
                case (row_addr)
                    3'd0: row_data = 5'b11111;
                    3'd1: row_data = 5'b00100;
                    3'd2: row_data = 5'b00100;
                    3'd3: row_data = 5'b00100;
                    3'd4: row_data = 5'b00100;
                    3'd5: row_data = 5'b00100;
                    3'd6: row_data = 5'b00100;
                    default: row_data = 5'b00000;
                endcase
            end

            // U
            8'h55: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b10001;
                    3'd4: row_data = 5'b10001;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b01110;
                    default: row_data = 5'b00000;
                endcase
            end

            // V
            8'h56: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b10001;
                    3'd4: row_data = 5'b01010;
                    3'd5: row_data = 5'b01010;
                    3'd6: row_data = 5'b00100;
                    default: row_data = 5'b00000;
                endcase
            end

            // W
            8'h57: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b10001;
                    3'd3: row_data = 5'b10101;
                    3'd4: row_data = 5'b10101;
                    3'd5: row_data = 5'b11011;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // X
            8'h58: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b01010;
                    3'd3: row_data = 5'b00100;
                    3'd4: row_data = 5'b01010;
                    3'd5: row_data = 5'b10001;
                    3'd6: row_data = 5'b10001;
                    default: row_data = 5'b00000;
                endcase
            end

            // Y
            8'h59: begin
                case (row_addr)
                    3'd0: row_data = 5'b10001;
                    3'd1: row_data = 5'b10001;
                    3'd2: row_data = 5'b01010;
                    3'd3: row_data = 5'b00100;
                    3'd4: row_data = 5'b00100;
                    3'd5: row_data = 5'b00100;
                    3'd6: row_data = 5'b00100;
                    default: row_data = 5'b00000;
                endcase
            end

            // Z
            8'h5A: begin
                case (row_addr)
                    3'd0: row_data = 5'b11111;
                    3'd1: row_data = 5'b00001;
                    3'd2: row_data = 5'b00010;
                    3'd3: row_data = 5'b00100;
                    3'd4: row_data = 5'b01000;
                    3'd5: row_data = 5'b10000;
                    3'd6: row_data = 5'b11111;
                    default: row_data = 5'b00000;
                endcase
            end

            // SPACE
            8'h20:
                row_data = 5'b00000;

            // Unsupported characters
            default:
                row_data = 5'b00000;

        endcase

    end

endmodule
