`timescale 1ns / 1ps

module clock_divider(masterclk, onehzclk, fastclk);
input masterclk;
output reg onehzclk;

output reg fastclk;


integer counter1 = 0;

integer fastcounter = 0;


always @(posedge masterclk)
begin
    
    if (counter1 == 49999999)
    begin
        counter1 <= 0;
        onehzclk <= ~onehzclk;
    end
    else 
    begin
            counter1 <= counter1 + 1;
    end
    
   
     
    // change this value based on how often we want to toggle fastclk
    if (fastcounter >= 49999)
    begin
        fastcounter <= 0;
        fastclk <= ~fastclk;
    end
    else 
    begin
        fastcounter <= fastcounter + 1;
    end

   

   
    
end 



endmodule
