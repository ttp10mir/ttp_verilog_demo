`timescale 1ns / 1ps

module tb_tt_um_multi;

    // Testbench signals
    reg [7:0] ui_in;        // Inputs
    wire [7:0] uo_out;      // Outputs
    reg [7:0] uio_in;       // Bidirectional input (not used)
    wire [7:0] uio_out;     // Bidirectional output (not used)
    wire [7:0] uio_oe;      // Bidirectional enable (not used)
    reg ena;                // Enable signal
    reg clk;                // Clock signal
    reg rst_n;              // Reset signal

    // Instantiate the design under test (DUT)
    tt_um_multi dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        // Initialize signals
        rst_n = 0;
        ena = 0;
        ui_in = 8'b0;
        uio_in = 8'b0;

        // Apply reset
        #10;
        rst_n = 1; // Deassert reset
        #10;

        // Test case 1: Multiply 3 (q) by 4 (m)
        ui_in = 8'b00000100; // q[3:0] = 4, m[3:0] = 3
        ena = 1;             // Enable the multiplier
        #10;

        // Check the result
        $display("Test Case 1: q=4, m=3, product=%d (expected: 12)", uo_out);

        // Test case 2: Multiply 7 (q) by 5 (m)
        ui_in = 8'b01000111; // q[3:0] = 7, m[3:0] = 5
        #10;

        // Check the result
        $display("Test Case 2: q=7, m=5, product=%d (expected: 35)", uo_out);

        // Test case 3: Multiply 15 (q) by 15 (m)
        ui_in = 8'b11111111; // q[3:0] = 15, m[3:0] = 15
        #10;

        // Check the result
        $display("Test Case 3: q=15, m=15, product=%d (expected: 225)", uo_out);

        // Test case 4: Multiply 0 (q) by 8 (m)
        ui_in = 8'b10000000; // q[3:0] = 0, m[3:0] = 8
        #10;

        // Check the result
        $display("Test Case 4: q=0, m=8, product=%d (expected: 0)", uo_out);

        // Complete the simulation
        $stop;
    end

endmodule

