`timescale 1ns / 1ps

module debounce(clk, btn, btn_db);

input wire clk;
input wire btn;
output reg btn_db;

    // Parameters
    parameter DELAY = 100000; // Adjust this for debouncing delay (~1ms for 100 MHz clock)

    // Registers
    reg [16:0] counter = 0;    // Counter to track stability period
    reg btn_sync_1 = 0;         // First stage of synchronization (metastability protection)
    reg btn_sync_2 = 0;         // Second stage of synchronization (cleaned signal)
    reg btn_stable = 0;         // Final stable state of the button

    // Synchronizer for metastability
    always @(posedge clk) begin
        btn_sync_1 <= btn;
        btn_sync_2 <= btn_sync_1;
    end

    // Debouncing logic
    always @(posedge clk) begin
        if (btn_sync_2 != btn_stable) begin
            counter <= counter + 1;
            if (counter >= DELAY) begin
                btn_stable <= btn_sync_2; // Update stable state after delay
                counter <= 0; // Reset counter
            end
        end else begin
            counter <= 0; // Reset counter if no change
        end
    end

    // Output debounced button
    always @(posedge clk) begin
        btn_db <= btn_stable;
    end

endmodule
