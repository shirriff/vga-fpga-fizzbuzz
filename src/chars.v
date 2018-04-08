`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Character generator holding 8x8 character images.
// Input char is a 4-bit character number representing:
// 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, B, F, i, z, <blank>
// Input rownum is the desired row of the pixel image
// Output pixels is the 8 pixel row, pixels[7] is leftmost.
// Original font from https://github.com/dhepper/font8x8/blob/master/font8x8_basic.h
module chars(
    input [3:0] char,
    input [2:0] rownum,
    output reg [7:0] pixels
    );

always @(*)
  case ({char, rownum})
    7'b0000000: pixels = 8'b01111100; //  XXXXX  
    7'b0000001: pixels = 8'b11000110; // XX   XX 
    7'b0000010: pixels = 8'b11001110; // XX  XXX 
    7'b0000011: pixels = 8'b11011110; // XX XXXX 
    7'b0000100: pixels = 8'b11110110; // XXXX XX 
    7'b0000101: pixels = 8'b11100110; // XXX  XX 
    7'b0000110: pixels = 8'b01111100; //  XXXXX  
    7'b0000111: pixels = 8'b00000000; //         

    7'b0001000: pixels = 8'b00110000; //   XX    
    7'b0001001: pixels = 8'b01110000; //  XXX    
    7'b0001010: pixels = 8'b00110000; //   XX    
    7'b0001011: pixels = 8'b00110000; //   XX    
    7'b0001100: pixels = 8'b00110000; //   XX    
    7'b0001101: pixels = 8'b00110000; //   XX    
    7'b0001110: pixels = 8'b11111100; // XXXXXX  
    7'b0001111: pixels = 8'b00000000; //         

    7'b0010000: pixels = 8'b01111000; //  XXXX   
    7'b0010001: pixels = 8'b11001100; // XX  XX  
    7'b0010010: pixels = 8'b00001100; //     XX  
    7'b0010011: pixels = 8'b00111000; //   XXX   
    7'b0010100: pixels = 8'b01100000; //  XX     
    7'b0010101: pixels = 8'b11001100; // XX  XX  
    7'b0010110: pixels = 8'b11111100; // XXXXXX  
    7'b0010111: pixels = 8'b00000000; //         

    7'b0011000: pixels = 8'b01111000; //  XXXX   
    7'b0011001: pixels = 8'b11001100; // XX  XX  
    7'b0011010: pixels = 8'b00001100; //     XX  
    7'b0011011: pixels = 8'b00111000; //   XXX   
    7'b0011100: pixels = 8'b00001100; //     XX  
    7'b0011101: pixels = 8'b11001100; // XX  XX  
    7'b0011110: pixels = 8'b01111000; //  XXXX   
    7'b0011111: pixels = 8'b00000000; //         

    7'b0100000: pixels = 8'b00011100; //    XXX  
    7'b0100001: pixels = 8'b00111100; //   XXXX  
    7'b0100010: pixels = 8'b01101100; //  XX XX  
    7'b0100011: pixels = 8'b11001100; // XX  XX  
    7'b0100100: pixels = 8'b11111110; // XXXXXXX 
    7'b0100101: pixels = 8'b00001100; //     XX  
    7'b0100110: pixels = 8'b00011110; //    XXXX 
    7'b0100111: pixels = 8'b00000000; //         

    7'b0101000: pixels = 8'b11111100; // XXXXXX  
    7'b0101001: pixels = 8'b11000000; // XX      
    7'b0101010: pixels = 8'b11111000; // XXXXX   
    7'b0101011: pixels = 8'b00001100; //     XX  
    7'b0101100: pixels = 8'b00001100; //     XX  
    7'b0101101: pixels = 8'b11001100; // XX  XX  
    7'b0101110: pixels = 8'b01111000; //  XXXX   
    7'b0101111: pixels = 8'b00000000; //         

    7'b0110000: pixels = 8'b00111000; //   XXX   
    7'b0110001: pixels = 8'b01100000; //  XX     
    7'b0110010: pixels = 8'b11000000; // XX      
    7'b0110011: pixels = 8'b11111000; // XXXXX   
    7'b0110100: pixels = 8'b11001100; // XX  XX  
    7'b0110101: pixels = 8'b11001100; // XX  XX  
    7'b0110110: pixels = 8'b01111000; //  XXXX   
    7'b0110111: pixels = 8'b00000000; //         

    7'b0111000: pixels = 8'b11111100; // XXXXXX  
    7'b0111001: pixels = 8'b11001100; // XX  XX  
    7'b0111010: pixels = 8'b00001100; //     XX  
    7'b0111011: pixels = 8'b00011000; //    XX   
    7'b0111100: pixels = 8'b00110000; //   XX    
    7'b0111101: pixels = 8'b00110000; //   XX    
    7'b0111110: pixels = 8'b00110000; //   XX    
    7'b0111111: pixels = 8'b00000000; //         

    7'b1000000: pixels = 8'b01111000; //  XXXX   
    7'b1000001: pixels = 8'b11001100; // XX  XX  
    7'b1000010: pixels = 8'b11001100; // XX  XX  
    7'b1000011: pixels = 8'b01111000; //  XXXX   
    7'b1000100: pixels = 8'b11001100; // XX  XX  
    7'b1000101: pixels = 8'b11001100; // XX  XX  
    7'b1000110: pixels = 8'b01111000; //  XXXX   
    7'b1000111: pixels = 8'b00000000; //         

    7'b1001000: pixels = 8'b01111000; //  XXXX   
    7'b1001001: pixels = 8'b11001100; // XX  XX  
    7'b1001010: pixels = 8'b11001100; // XX  XX  
    7'b1001011: pixels = 8'b01111100; //  XXXXX  
    7'b1001100: pixels = 8'b00001100; //     XX  
    7'b1001101: pixels = 8'b00011000; //    XX   
    7'b1001110: pixels = 8'b01110000; //  XXX    
    7'b1001111: pixels = 8'b00000000; //         

    7'b1010000: pixels = 8'b11111100; // XXXXXX  
    7'b1010001: pixels = 8'b01100110; //  XX  XX 
    7'b1010010: pixels = 8'b01100110; //  XX  XX 
    7'b1010011: pixels = 8'b01111100; //  XXXXX  
    7'b1010100: pixels = 8'b01100110; //  XX  XX 
    7'b1010101: pixels = 8'b01100110; //  XX  XX 
    7'b1010110: pixels = 8'b11111100; // XXXXXX  
    7'b1010111: pixels = 8'b00000000; //         

    7'b1011000: pixels = 8'b11111110; // XXXXXXX 
    7'b1011001: pixels = 8'b01100010; //  XX   X 
    7'b1011010: pixels = 8'b01101000; //  XX X   
    7'b1011011: pixels = 8'b01111000; //  XXXX   
    7'b1011100: pixels = 8'b01101000; //  XX X   
    7'b1011101: pixels = 8'b01100000; //  XX     
    7'b1011110: pixels = 8'b11110000; // XXXX    
    7'b1011111: pixels = 8'b00000000; //         

    7'b1100000: pixels = 8'b00110000; //   XX
    7'b1100001: pixels = 8'b00000000; //
    7'b1100010: pixels = 8'b01110000; //  XXX
    7'b1100011: pixels = 8'b00110000; //   XX
    7'b1100100: pixels = 8'b00110000; //   XX
    7'b1100101: pixels = 8'b00110000; //   XX
    7'b1100110: pixels = 8'b01111000; //  XXXX
    7'b1100111: pixels = 8'b00000000; //

    7'b1101000: pixels = 8'b00000000; //
    7'b1101001: pixels = 8'b00000000; //
    7'b1101010: pixels = 8'b11001100; // XX  XX
    7'b1101011: pixels = 8'b11001100; // XX  XX
    7'b1101100: pixels = 8'b11001100; // XX  XX
    7'b1101101: pixels = 8'b11001100; // XX  XX
    7'b1101110: pixels = 8'b01110110; //  XXX XX
    7'b1101111: pixels = 8'b00000000; //

    7'b1110000: pixels = 8'b00000000; //
    7'b1110001: pixels = 8'b00000000; //
    7'b1110010: pixels = 8'b11111100; // XXXXXX
    7'b1110011: pixels = 8'b10011000; // X  XX
    7'b1110100: pixels = 8'b00110000; //   XX
    7'b1110101: pixels = 8'b01100100; //  XX  X
    7'b1110110: pixels = 8'b11111100; // XXXXXX
    7'b1110111: pixels = 8'b00000000; //
    
    default: pixels = 8'b00000000;
  endcase
endmodule
