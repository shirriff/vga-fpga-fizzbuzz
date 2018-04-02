module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output[7:0]led,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy, // AVR Rx buffer full
    output pin_r,
    output pin_g,
    output pin_b,
    output pin_hsync,
    output pin_vsync
    );

wire rst = ~rst_n; // make reset active high

// these signals should be high-z when not used
assign spi_miso = 1'bz;
assign avr_rx = 1'bz;
assign spi_channel = 4'bzzzz;

wire [9:0] x;
wire [9:0] y;

vga vga(
  .clk(clk),
  .rst(rst),
  .x(x[9:0]),
  .y(y[9:0]),
  .valid(valid),
  .hsync(hsync),
  .vsync(vsync),
  .newframe(newframe),
  .newline(newline)
  );

wire [7:0] pixels;

wire [31:0] line;
reg [3:0] char;

// Shift x position to move fizz/buzz lines
wire [9:0] x1 = isnum ? x : x - framecount[8:1];

// Map the position on the line to a character
always @(*)
case (x1[9:3])
  7'd1: char = line[3:0];
  7'd2: char = line[7:4];
  7'd3: char = line[11:8];
  7'd4: char = line[15:12];
  7'd5: char = line[19:16];
  7'd6: char = line[23:20];
  7'd7: char = line[27:24];
  7'd8: char = line[31:28];
  default: char = 4'd15;
endcase

// Character generator
chars chars(
  .char(char),
  .rownum(y[2:0]),
  .pixels(pixels)
  );
  
// Main loop for FizzBuzz
fizzbuzz fizzbuzz(
  .clk(clk),
  .rst(newframe),
  .next(newline && (y[2:0] == 3'd0)),
  .led(led),
  .line(line),
  .isnum(isnum)
  );
  
assign pin_r = rval;
assign pin_g = gval;
assign pin_b = bval;
assign pin_hsync = hsync;
assign pin_vsync = vsync;

reg [8:0] framecount;
always @(posedge clk) begin
  if (rst)
    framecount <= 0;
  else if (newframe)
    framecount <= framecount + 1'b1;
end

// "Buzz" bouncing around the screen
bigword bigBuzz(
  .clk(clk),
  .rst(rst),
  .fizzOrBuzz(1'b0), // Buzz
  .newframe(newframe),
  .x(x),
  .y(y),
  .out(buzzPixel)
    );
 
// "Fizz" bouncing around the screen 
bigword bigFizz(
  .clk(clk),
  .rst(rst),
  .fizzOrBuzz(1'b1), // Fizz
  .newframe(newframe),
  .x(x),
  .y(y),
  .out(fizzPixel)
    );
    
// Generate the pixel output
reg rval, gval, bval;

reg rainbow_r, rainbow_g, rainbow_b;

always @(*) begin
  rval = 0;
  gval = 0;
  bval = 0;
  // Determine this line's color of the rainbow
  rainbow_r = 0;
  rainbow_g = 0;
  rainbow_b = 0;
  case (y[2:0])
    3'd0: begin rainbow_b = 1; rainbow_r=1; end
    3'd1, 3'd2: rainbow_r = 1;
    3'd3, 3'd4: begin rainbow_r = 1; rainbow_g = 1; end
    3'd5: rainbow_g = 1;
    3'd6, 3'd7: begin rainbow_g = 1; rainbow_b = 1; end
  endcase
  
  // Combine the objects to determine the final pixel color
  if (valid) begin
    // Floating "Fizz"
    if (fizzPixel) begin
      rval = 1;
      gval = 0;
      bval = 0;
    end
    
    if (isnum) begin
      // Output line: normal digits
      if (pixels[7-x[2:0]]) begin
        rval = 1;
        gval = 1;
        bval = 1;
      end
    end else begin
      // Output line: rainbow
      if (pixels[7-x1[2:0]] || (x > 7 && x < framecount[8:1] + 7)) begin
        rval = rainbow_r;
        gval = rainbow_g;
        bval = rainbow_b;
      end
    end

    // Floating "Buzz" text : rainbow
    if (buzzPixel) begin
      bval = rainbow_r;
      rval = rainbow_g;
      gval = rainbow_b;
    end
  end
end

endmodule