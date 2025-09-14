`timescale 1ns / 1ps

module spi_master(
    input wire clk,        // System clock
    input wire rst,        // Reset
    output reg sclk,       // SPI clock
    output reg mosi,       // Master Out, Slave In
    input wire miso,       // Master In, Slave Out
    output reg cs,         // Chip select (active low)
    output reg [9:0] x_pos, // X-axis position
    output reg [9:0] y_pos, // Y-axis position
    output reg move_detect // Joystick movement detected
);
    
    reg [7:0] spi_data [4:0]; // Storage for received bytes
    reg [5:0] bit_count;      // Count bits sent/received
    reg [2:0] byte_count;     // Count bytes sent/received
    reg [9:0] center = 10'd512; // Center position reference
    reg [9:0] threshold = 10'd100; // Movement threshold

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cs <= 1; // Start with chip select high (inactive)
            bit_count <= 0;
            byte_count <= 0;
            move_detect <= 0;
        end else begin
            // SPI transaction logic
            if (bit_count == 40) begin
                cs <= 1; // Deselect joystick
                x_pos <= {spi_data[1][1:0], spi_data[0]}; // Extract 10-bit X position
                y_pos <= {spi_data[3][1:0], spi_data[2]}; // Extract 10-bit Y position
                
                // Detect movement
                if ((x_pos > center + threshold) || (x_pos < center - threshold) ||
                    (y_pos > center + threshold) || (y_pos < center - threshold)) 
                    move_detect <= 1;
                else
                    move_detect <= 0;

                bit_count <= 0;
                byte_count <= 0;
            end else begin
                cs <= 0; // Enable SPI communication
                // SPI transmission and reception logic
                // (Add logic to shift bits to mosi and read miso)
                 // SPI bit-shifting to capture data
                           if (bit_count[2:0] == 7) begin
                               spi_data[byte_count] <= {spi_data[byte_count][6:0], miso}; // Shift in bits
                               if (byte_count < 4)
                                   byte_count <= byte_count + 1;
                           end
                bit_count <= bit_count + 1;
            end
        end
    end

endmodule
