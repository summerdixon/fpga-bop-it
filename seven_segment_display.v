`timescale 1ns / 1ps

module seven_segment_display(clk, onehzclk, command, seg, an);

input wire clk;
input wire onehzclk;
input wire [1:0] command;

output reg [6 : 0] seg;
output reg [3 : 0] an;

reg [1 : 0] letter_select = 0;
reg [3 : 0] letter_value;
reg [15 : 0] command_16;

always @(posedge clk) begin
    letter_select <= letter_select +1;
    if (letter_select == 3)
        letter_select <= 0;
end

 always @(*)
    
    begin
    
    if (command == 2'b11 && onehzclk)
        begin
            seg = 7'b1111111;
            an = 4'b1111;
        end
    else
    begin
        case (command)
           2'b00: begin
           command_16 = 16'b0000001101001111;
             
           end
           
           2'b01: begin
           command_16  = 16'b0100100000010001;
           end
           
           2'b10: begin
           command_16 = 16'b0111100001010010;
           end
           
           2'b11: begin
           command_16 = 16'b0001001101100110;
           end
           
           default: begin
           command_16 = 16'b1111111111111111;
           end
           endcase
        
        case(letter_select)
        2'b00: begin
            an = 4'b0111; 
            letter_value = command_16[15 : 12]; 
        end
        2'b01: begin
            an = 4'b1011; 
            letter_value = command_16[15 : 8];
        end
        2'b10: begin
            an = 4'b1101; 
            letter_value = command_16[7 : 4];
        end
        2'b11: begin
            an = 4'b1110; 
            letter_value = command_16[3 : 0];
        end
        
        
        endcase
        
        case(letter_value)
                    4'b0000: seg = 7'b0000011; // "b"
                    4'b0001: seg = 7'b1111001; // "l"
                    4'b0010: seg = 7'b0101011; // "n"
                    4'b0011: seg = 7'b0100011; // "o"
                    4'b0100: seg = 7'b0001100; // "p"
                    4'b0101: seg = 7'b0101111; // "r"
                    4'b0110: seg = 7'b0010010; // "s"
                    4'b0111: seg = 7'b0000111; // "t"
                    4'b1000: seg = 7'b1100011; // "u"
                    default: seg = 7'b1111111; // Default "blank"
                endcase
//                  
      end
                
end


endmodule
