`timescale 1ns / 1ps
module vga(
    input clk,
    input rst,
    output reg [9:0] x,
    output reg [9:0] y,
    output valid,
    output hsync,
    output vsync,
    output reg newframe, // 1 clock pulse when new frame starts
    output reg newline // 1 clock pulse when new line starts
    );
    
reg clk25; // 25MHz signal (clk divided by 2)

assign hsync = x < (640 + 16) || x >= (640 + 16 + 96);
assign vsync = y < (480 + 10) || y >= (480 + 10 + 2);
assign valid = (x < 640) && (y < 480);

always @(posedge clk) begin
  newframe <= 0;
  newline <= 0;
  if (rst) begin
    x <= 10'b0;
    y <= 10'b0;
    clk25 <= 1'b0;
    newframe <= 1;
    newline <= 1;
  end else begin
    clk25 <= ~clk25;
    if (clk25 == 1'b1) begin
      if (x < 10'd799) begin
        x <= x + 1'b1;
      end else begin
        x <= 10'b0;
        newline <= 1;
        if (y < 10'd524) begin
          y <= y + 1'b1;
        end else begin
          y <= 10'b0;
          newframe <= 1;
        end
      end
    end
  end
end

endmodule
