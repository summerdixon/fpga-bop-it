`timescale 1ns / 1ps
`timescale 1ns / 1ps

module clock_divider_tb;

    reg masterclk; 
    wire onehzclk;  // Simulated 1Hz clock
    //wire twohzclk;
    wire fastclk;   // Simulated fast clock for refreshing display
    reg rst;     // Reset signal
//    wire [3:0] Anode_Activate; // Active anode (which digit is lit)
//    wire [6:0] LED_out; // 7-segment cathode output
//    wire [5 : 0] seconds;
//    wire [5:0] minutes;

    // Instantiate the clock display module
    // masterclk, onehzclk, twohzclk, fastclk, rst
    clock_divider uut1 (
        .masterclk(masterclk),
        .onehzclk(onehzclk),
        .fastclk(fastclk)
    );

    // onehzclk, fastclk, rst, Anode_Activate, LED_out
//    digits uut2 (
//        .onehzclk(onehzclk),
//        .fastclk(fastclk),
//        .rst(rst),
//        .Anode_Activate(Anode_Activate),
//        .LED_out(LED_out),
//        .seconds(seconds),
//        .minutes(minutes)
//    );
    
    

    // **Simulated Clocks**
    always #5 masterclk = ~masterclk; // Toggle every 500ms (1Hz clock)
//    always #5000 fastclk = ~fastclk; // Fast clock toggling every 5µs

  
    // **Test Process**
    initial begin
        $display("Starting Simulation...");
        
        masterclk = 0;
        rst = 1;
        #10 rst = 0; // Release reset
        
        #2000000000;
        $display("Simulation Complete.");
        $finish;
    end
    always @(posedge onehzclk or negedge onehzclk) begin
        $display("Time: %0t ns | onehzclk toggled to %b", $time, onehzclk);
        $display("Time: %0t ns | twohzclk toggled to %b", $time, twohzclk);

    end
    
//    initial begin
//    $monitor ("Time: %0t | masterclk: %b | onehzclk: %b | fastclk: %b | rst: %b",
//                    $time, masterclk, onehzclk, fastclk, rst);
//    end



endmodule