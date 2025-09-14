`timescale 1ns / 1ps

module bopit (masterclk, BUTTON, SWITCH, JOYSTICK1, JOYSTICK2, miso, mosi, sclk, cs, LED_loss, LED_bop, LED_pull, LED_turn, seg, an, ext_seg, ext_an);

    input wire masterclk;
    input wire BUTTON;
    input wire SWITCH;
    input wire JOYSTICK1;
    input wire JOYSTICK2;
    input wire miso;       // SPI input from joystick
    output wire mosi;      // SPI output to joystick
    output wire sclk;      // SPI clock
    output wire cs;        // SPI chip select
    output wire [6:0] seg;
    output wire [3:0] an;
    output wire [6:0] ext_seg;
    output wire ext_an;
    output reg LED_loss;
    output reg LED_bop;
    output reg LED_pull;
    output reg LED_turn;

    wire BUTTON_DB;
    wire JOYSTICK1_DB;
    wire JOYSTICK2_DB;
    wire onehzclk;
    wire fastclk;
    reg [1:0] command;
    reg [6:0] score;
    reg [6:0] next_score;
    reg [2:0] time_left;
    reg [2:0] loss_time_left;
    reg prev_switch;
    
    parameter CENTER = 10'd512;
    parameter THRESHOLD = 10'd200;

    wire [9:0] x_pos;
    wire [9:0] y_pos;
    wire move_detect;

    clock_divider clk_div (
        .masterclk(masterclk),
        .onehzclk(onehzclk),
        .fastclk(fastclk)
    );

    debounce db_button (
        .clk(masterclk), 
        .btn(BUTTON), 
        .btn_db(BUTTON_DB)
    );
    
    debounce db_joystick1 (
        .clk(masterclk), 
        .btn(JOYSTICK1), 
        .btn_db(JOYSTICK1_DB)
    );
        
    debounce db_joystick2 (
        .clk(masterclk), 
        .btn(JOYSTICK2), 
        .btn_db(JOYSTICK2_DB)
    );

    spi_master spi (
        .clk(masterclk),
        .rst(1'b0), // Active-low reset, change if needed
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .cs(cs),
        .x_pos(x_pos),
        .y_pos(y_pos),
        .move_detect(move_detect) // Detect joystick movement
    );

    initial begin
        command = 2'b00;
        time_left = 3;
        loss_time_left = 3;
        score = 0;
        LED_loss = 0;
        prev_switch = SWITCH;
    end

    always @(posedge onehzclk) begin
            next_score <= score;
            if (time_left == 0) 
            begin
                command <= 2'b11; // Loss condition
                if(loss_time_left == 0)
                begin
                    command <= 2'b11;
                    score <= 0;
                end
                else
                    loss_time_left <= loss_time_left - 1;
            end 
            else begin
                if (SWITCH != prev_switch)
                    prev_switch <= SWITCH;
                
                if (
                    (command == 2'b00 && BUTTON_DB) ||
                    (command == 2'b01 && SWITCH != prev_switch) ||
                    (command == 2'b10 && JOYSTICK1_DB && JOYSTICK2_DB) // Use move_detect instead of direct X/Y checks
                ) begin
                    //increment score
                    score <= score + 1;
                
                    //check score
                    //if score >= 10 make time left be 2
                    //if score >= 20 make time left be 1
                    if (next_score >= 20)
                        time_left <= 1;
                    else if (next_score >= 10)
                        time_left <= 2;
                    else if (next_score < 10)
                        time_left <= 3;
                            
                    // i.e. score is 4, 8, 12, 16, …
                        if (next_score % 4 == 0)
                        command <= 2'b00;
                        
                        // i.e. score is 5, 9, 13, 17, …
                        else if (next_score % 4 == 1)
                        begin
                            if (next_score % 3 == 0)
                                command <= 2'b10;
                            else
                        command <= 2'b01;
                        end
                        
                        // i.e. score is 6, 10, 14, 20, …
                        else if (next_score % 4 == 2)
                        begin
                            if (next_score % 5 == 0)
                        command <= 2'b10;
                        else
                            command <= 2'b00;
                        end
                        
                        // i.e. score is 7, 11, 15, 21, …
                        else if (next_score % 4 == 3)
                        begin
                        if (next_score % 3 == 0)
                        command <= 2'b00;
                        else 
                        command <= 2'b01;
                        end
   
                end else begin
                    time_left <= time_left - 1; // Countdown
                end
            end
    end
    
    always @(*) begin
        case (command)
            2'b00: begin
                LED_bop = 1;
                LED_pull = 0;
                LED_turn = 0;  
            end
            2'b01: begin
                LED_bop = 0;
                LED_pull = 1;
                LED_turn = 0;  
            end
            2'b10: begin
                LED_bop = 0;
                LED_pull = 0;
                LED_turn = 1;  
            end
            2'b11: begin
                LED_loss = 1; 
                LED_bop = 0;
                LED_pull = 0;
                LED_turn = 0; 
            end
        endcase
    end



    seven_segment_display ssd (
        .clk(fastclk),
        .onehzclk(onehzclk),
        .command(command),
        .seg(seg),
        .an(an)
    );
    
    ext_seven_segment_display ext_ssd (
            .clk(fastclk),
            .onehzclk(onehzclk),
            .command(command),
            .score(score),
            .ext_seg(ext_seg),
            .ext_an(ext_an)
        );

endmodule
