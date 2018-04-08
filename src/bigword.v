`timescale 1ns / 1ps
module bigword(
    input clk,
    input rst,
    input newframe,
    input [9:0] x, // Current pixel to evaluate
    input [9:0] y,
    input fizzOrBuzz,
    output reg out // 1 = set pixel
    );

reg dx, dy; // 1 = increment, 0 = decrement
reg [9:0] xpos; // Position of the moving box
reg [9:0] ypos;

reg [3:0] char; // Character to display
wire [7:0] pixels; // Pixels making up one row of the character

// Figure out which character to display at this position
always @(*) begin
  case (xoffset[7:6]) // Each character is 64 pixels wide
    2'd0: char = fizzOrBuzz ? 4'd10 : 4'd11; // B or F
    2'd1: char = fizzOrBuzz ? 4'd13 : 4'd12; // u or i
    2'd2, 2'd3: char = 4'd14; // z
  endcase
end

// Character generator
chars chars(
  .char(char),
  .rownum(yoffset[5:3]),
  .pixels(pixels)
  );

localparam scale = 8; // Scale character size by 8

wire [10:0] xoffset = x - xpos; // Pixel position relative to box
wire [10:0] yoffset = y - ypos;
    
// Handle the bouncing rectangle
always @(posedge clk) begin
  if (rst) begin
    dx <= fizzOrBuzz ? 1'b1 : 1'b0; // Start words in opposite directions
    dy <= fizzOrBuzz ? 1'b1 : 1'b0;
    xpos <= 10'd320;
    ypos <= fizzOrBuzz ? 10'd10 : 10'd300;
  end else begin
    if (newframe) begin
      // Bounce
      if (xpos <= 1)
        dx <= 1;
      else if (xpos > 640-4*8*scale)
        dx <= 0;
      if (ypos <= 1)
        dy <= 1;
      else if (ypos > 480 - 8*scale)
        dy <= 0;
      xpos <= dx ? xpos + 1'b1 : xpos - 1'b1;
      ypos <= dy ? ypos + 1'b1 : ypos - 1'b1;
    end

    // Output the pixel if inside the rectangle
    if (xoffset >= 0 && xoffset < 4*8*scale && yoffset >= 0 && yoffset < 8*scale) begin
      out <= pixels[7-xoffset[5:3]];
    end else begin
      out <= 0;
    end
  end
end

endmodule
