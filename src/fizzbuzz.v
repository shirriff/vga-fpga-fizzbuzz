`timescale 1ns / 1ps

// Main fizzbuzz loop
// Ken Shirriff  http://righto.com

// The fizzbuzz problem is to output the numbers 1 to 100 except
// Output "Fizz" if the number is divisible by 3.
// Output "Buzz" if the number is divisible by 5.
// Output "Fizzbuzz" if the number is divisible by both.

// The algorithm is to have a BCD counter incremented from 1 to 100.
// Store count mod 3 in "mod3", and count mod 5 in "mod5".
// That way the modulo values can be simply incremented rather than an
// expensive modulo operation.

// Writes ASCII fizzbuzz output as 9600 baud serial.

module fizzbuzz(
  input clk,
  input rst,
  input next,        // Move to next value
  output [7:0] led,  // Diagnostic LED
  output reg [31:0] line,    // Output characters: 8 characters of 4 bits each
  output reg isnum // Is a number, not fizz, buzz, fizzbuzz
  );

reg [1:0] mod3; // Current value mod 3
reg [2:0] mod5; // Current value mod 5

assign led = mod5;

// The 3-digit BCD counter.
wire [3:0] digit2, digit1, digit0;
bcd_counter bcd_counter(
  .clk(clk),
  .rst(rst),
  .increment(next),
  .digit2(digit2),
  .digit1(digit1),
  .digit0(digit0)
);

localparam CHAR_B = 4'd10, CHAR_F = 4'd11, CHAR_I = 4'd12, CHAR_U = 4'd13,
  CHAR_Z = 4'd14;
  
// Main loop
always @(posedge clk) begin
  if (rst) begin
    // Start with BCD value 001 and modulo values 10
    mod3 <= 2'd1;
    mod5 <= 3'd1;
  end else begin
    if (next) begin
      // Move to next counter value
      mod3 <= (mod3 == 2) ? 2'b0 : mod3 + 1'b1;
      mod5 <= (mod5 == 4) ? 3'b0 : mod5 + 1'b1;
    end
    line[31:0] <= ~0;
    isnum <= 0;
    if (mod3 == 0 && mod5 != 0) begin
      // Fizz
      line[3:0] <= CHAR_F;
      line[7:4] <= CHAR_I;
      line[11:8] <= CHAR_Z;
      line[15:12] <= CHAR_Z;
    end else if (mod3 != 0 && mod5 == 0) begin
      // Buzz
      line[3:0] <= CHAR_B;
      line[7:4] <= CHAR_U;
      line[11:8] <= CHAR_Z;
      line[15:12] <= CHAR_Z;
     end else if (mod3 == 0 && mod5 == 0) begin      
       // Fizzbuzz
       line[3:0] <= CHAR_F;
       line[7:4] <= CHAR_I;
       line[11:8] <= CHAR_Z;
       line[15:12] <= CHAR_Z;
       line[19:16] <= CHAR_B;
       line[23:20] <= CHAR_U;
       line[27:24] <= CHAR_Z;
       line[31:28] <= CHAR_Z;
    end else begin 
      // No divisors; output the digits of the number.
      isnum <= 1;
      if (digit2 == 0) begin
        if (digit1 == 0) begin
          // Suppress leading zeros
          line[3:0] <= digit0;
        end else begin
          line[3:0] <= digit1;
          line[7:4] <= digit0;
        end
      end else begin
        line[3:0] <= digit2;
        line[7:4] <= digit1;
        line[11:8] <= digit2;
      end
    end
  end
end

endmodule
