`timescale 1ns / 1ps

module tb_hub75_top;

    // =========================================================
    // Testbench signals
    // =========================================================

    reg        clk;
    reg        rst_n;

    reg [7:0]  ascii_in;
    reg [2:0]  char_sel;
    reg        load;

    // =========================================================
    // HUB75 outputs
    // =========================================================

    wire HUB75_CLK;

    wire HUB75_A;
    wire HUB75_B;
    wire HUB75_C;

    wire HUB75_LAT;
    wire HUB75_OE;

    wire HUB75_R1;
    wire HUB75_G1;
    wire HUB75_B1;

    wire HUB75_R2;
    wire HUB75_G2;
    wire HUB75_B2;

    // =========================================================
    // Testbench variables
    // =========================================================

    integer rise_count;
    integer expected_row;

    // =========================================================
    // DUT
    // =========================================================

    hub75_top DUT (

        .clk        (clk),
        .rst_n      (rst_n),

        .ascii_in   (ascii_in),
        .char_sel   (char_sel),
        .load       (load),

        .HUB75_CLK  (HUB75_CLK),

        .HUB75_A    (HUB75_A),
        .HUB75_B    (HUB75_B),
        .HUB75_C    (HUB75_C),

        .HUB75_LAT  (HUB75_LAT),
        .HUB75_OE   (HUB75_OE),

        .HUB75_R1   (HUB75_R1),
        .HUB75_G1   (HUB75_G1),
        .HUB75_B1   (HUB75_B1),

        .HUB75_R2   (HUB75_R2),
        .HUB75_G2   (HUB75_G2),
        .HUB75_B2   (HUB75_B2)

    );

    // =========================================================
    // 50 MHz system clock
    // Period = 20 ns
    // =========================================================

    initial begin

        clk = 1'b0;

        forever #10 clk = ~clk;

    end

    // =========================================================
    // Character loading task
    // =========================================================

    task load_char;

        input [2:0] sel;
        input [7:0] ascii;

        begin

            @(negedge clk);

            char_sel = sel;
            ascii_in = ascii;
            load     = 1'b1;

            @(negedge clk);

            load = 1'b0;

        end

    endtask

    // =========================================================
    // MAIN TEST SEQUENCE
    // =========================================================

    initial begin

        // -----------------------------------------------------
        // Initial values
        // -----------------------------------------------------

        rst_n    = 1'b0;
        ascii_in = 8'h20;
        char_sel = 3'd0;
        load     = 1'b0;

        rise_count   = 0;
        expected_row = 0;

        // =====================================================
        // TEST 1: RESET
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 1: RESET");
        $display("==============================================");

        #100;

        if (HUB75_A !== 1'b0 ||
            HUB75_B !== 1'b0 ||
            HUB75_C !== 1'b0 ||
            HUB75_CLK !== 1'b0) begin

            $display("ERROR: Reset outputs are incorrect.");
            $stop;

        end

        $display("PASS: Reset outputs are correct.");

        // Release reset
        @(negedge clk);

        rst_n = 1'b1;

        // =====================================================
        // TEST 2: CHARACTER LOADING
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 2: CHARACTER LOADING");
        $display("==============================================");

        load_char(3'd0, "A");
        load_char(3'd1, "B");
        load_char(3'd2, "C");
        load_char(3'd3, "D");

        load_char(3'd4, "E");
        load_char(3'd5, "F");
        load_char(3'd6, "A");
        load_char(3'd7, "B");

        $display("PASS: Characters loaded.");
        $display("Upper = ABCD");
        $display("Lower = EFAB");

        // =====================================================
        // TEST 3: INITIAL ROW ADDRESS
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 3: INITIAL ROW ADDRESS");
        $display("==============================================");

        if (DUT.row_addr !== 3'd0) begin

            $display("ERROR: Initial row address is not 000.");
            $display("Current row = %b", DUT.row_addr);

            $stop;

        end

        $display("PASS: Initial row address = 000.");

        // =====================================================
        // TEST 4: SHIFT PHASE
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 4: SHIFT PHASE");
        $display("==============================================");

        wait (DUT.shift_en == 1'b1);

        if (HUB75_OE !== 1'b1) begin

            $display("ERROR: OE should be HIGH during SHIFT.");
            $stop;

        end

        if (HUB75_LAT !== 1'b0) begin

            $display("ERROR: LAT should be LOW during SHIFT.");
            $stop;

        end

        $display("PASS: SHIFT phase is correct.");

        // =====================================================
        // TEST 5: HUB75 CLOCK
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 5: HUB75 CLOCK");
        $display("==============================================");

        rise_count = 0;

        while (DUT.shift_en == 1'b1) begin

            @(posedge HUB75_CLK);

            rise_count = rise_count + 1;

        end

        if (rise_count != 32) begin

            $display("ERROR: Expected 32 HUB75 rising edges.");
            $display("Actual count = %0d", rise_count);

            $stop;

        end

        $display("PASS: 32 HUB75 rising edges detected.");

        // =====================================================
        // TEST 6: LATCH
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 6: LATCH PHASE");
        $display("==============================================");

        wait (HUB75_LAT == 1'b1);

        if (HUB75_CLK !== 1'b0) begin

            $display("ERROR: HUB75_CLK should be LOW during LATCH.");
            $stop;

        end

        if (HUB75_OE !== 1'b1) begin

            $display("ERROR: OE should be HIGH during LATCH.");
            $stop;

        end

        $display("PASS: LATCH phase is correct.");

        // =====================================================
        // TEST 7: DISPLAY
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 7: DISPLAY PHASE");
        $display("==============================================");

        wait (DUT.display_en == 1'b1);

        if (HUB75_OE !== 1'b0) begin

            $display("ERROR: OE should be LOW during DISPLAY.");
            $stop;

        end

        if (HUB75_LAT !== 1'b0) begin

            $display("ERROR: LAT should be LOW during DISPLAY.");
            $stop;

        end

        $display("PASS: DISPLAY phase is correct.");
        $display("OE = 0 -> LEDs enabled.");

        // =====================================================
        // TEST 8: RGB OUTPUT MAPPING
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 8: RGB OUTPUT MAPPING");
        $display("==============================================");

        if (HUB75_R1 !== DUT.pixel_up ||
            HUB75_G1 !== DUT.pixel_up ||
            HUB75_B1 !== DUT.pixel_up) begin

            $display("ERROR: Upper RGB mapping is incorrect.");
            $stop;

        end

        if (HUB75_R2 !== DUT.pixel_down ||
            HUB75_G2 !== DUT.pixel_down ||
            HUB75_B2 !== DUT.pixel_down) begin

            $display("ERROR: Lower RGB mapping is incorrect.");
            $stop;

        end

        $display("PASS: RGB monochrome mapping is correct.");

        // =====================================================
        // TEST 9: ROW TRANSITION
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 9: ROW TRANSITION");
        $display("==============================================");

        @(negedge DUT.display_en);

        #1;

        if (DUT.row_addr !== 3'd1) begin

            $display("ERROR: Expected row 1 after row 0.");
            $display("Current row = %b", DUT.row_addr);

            $stop;

        end

        $display("PASS: Row transitioned 0 -> 1.");

        // =====================================================
        // TEST 10: ROW SEQUENCE
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 10: ROW SEQUENCE");
        $display("==============================================");

        for (expected_row = 2;
             expected_row <= 7;
             expected_row = expected_row + 1) begin

            @(negedge DUT.display_en);

            #1;

            if (DUT.row_addr !== expected_row[2:0]) begin

                $display("ERROR: Expected row %0d.", expected_row);
                $display("Current row = %0d", DUT.row_addr);

                $stop;

            end

            $display("PASS: Row %0d reached.", expected_row);

        end

        // =====================================================
        // TEST 11: ROW WRAP-AROUND
        // =====================================================

        $display("");
        $display("==============================================");
        $display("TEST 11: ROW WRAP-AROUND");
        $display("==============================================");

        @(negedge DUT.display_en);

        #1;

        if (DUT.row_addr !== 3'd0) begin

            $display("ERROR: Expected row wrap 7 -> 0.");
            $display("Current row = %b", DUT.row_addr);

            $stop;

        end

        $display("PASS: Row wrapped 7 -> 0.");

        // =====================================================
        // FINAL RESULT
        // =====================================================

        $display("");
        $display("==============================================");
        $display("ALL HUB75 TOP INTEGRATION TESTS PASSED");
        $display("==============================================");
        $display("");

        #100;

        $finish;

    end

endmodule
