module tt_um_multi (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // Will go high when the design is enabled
    input  wire       clk,      // Clock
    input  wire       rst_n     // Reset_n - low to reset
);

    // Map inputs
    wire [3:0] q;  // Multiplicand (q)
    wire [3:0] m;  // Multiplier (m)

    assign q = ui_in[3:0]; // q[0] = ui[0], q[1] = ui[1], q[2] = ui[2], q[3] = ui[3]
    assign m = ui_in[7:4]; // m[0] = ui[4], m[1] = ui[5], m[2] = ui[6], m[3] = ui[7]

    // Register to store the product
    reg [7:0] product;

    // Set IO pins to inactive (not used)
    assign uio_out = 8'b0;  // All bidirectional outputs are zero
    assign uio_oe = 8'b0;   // All bidirectional outputs are disabled

    // Output assignment
    assign uo_out = product; // Map the product to uo_out (p[0] to p[7])

    // Multiplier logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            product <= 8'b0;  // Reset the product to 0
        end else if (ena) begin
            product <= q * m; // Perform 4x4 multiplication when enabled
        end
    end

endmodule

