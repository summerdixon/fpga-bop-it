`timescale 1ns / 1ps


module ext_seven_segment_display(clk, onehzclk, command, score, ext_seg, ext_an);


input wire clk;
input wire onehzclk;
input wire [1:0] command;
input  wire [6 : 0] score; 

output reg [6 : 0] ext_seg;
output reg ext_an;


reg [1 : 0] digit_select = 0;
reg [3 : 0] digit_value;


always @(posedge clk) begin
    digit_select <= digit_select + 1;
end


 always @(*)
    begin
    if (command == 2'b11 && onehzclk)
            begin
                ext_seg = 7'b0000000;
                ext_an = ~ext_an;
            end
    else
        begin
        case(digit_select)
        2'b00: begin
            ext_an = 1; 
            digit_value = score / 10; // Tens place of score
        end
        2'b01: begin
            ext_an = 0; 
            digit_value = score % 10; // Ones place of score
        end
        endcase
        
         case(digit_value)
               4'b0000: ext_seg = 7'b0111111; // "0"
               4'b0001: ext_seg = 7'b0000110; // "1"
               4'b0010: ext_seg = 7'b1011011; // "2"
               4'b0011: ext_seg = 7'b1001111; // "3"
               4'b0100: ext_seg = 7'b1100110; // "4"
               4'b0101: ext_seg = 7'b1101101; // "5"
               4'b0110: ext_seg = 7'b1111101; // "6"
               4'b0111: ext_seg = 7'b0000111; // "7"
               4'b1000: ext_seg = 7'b1111111; // "8"
               4'b1001: ext_seg = 7'b1101111; // "9"
               default: ext_seg = 7'b0000000; // Blank (instead of default "0")
        endcase
    end

end




endmodule
