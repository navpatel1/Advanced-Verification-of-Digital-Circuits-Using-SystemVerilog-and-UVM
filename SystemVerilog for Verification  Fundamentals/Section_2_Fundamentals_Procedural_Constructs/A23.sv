// A23
// Assume a SPI module consists of serial clock signal “sclk”. Use an initial block to
// initialize sclk to '0 and Generate a 9 MHz square wave waveform for the Signal sclk. Assume a timescale of 1 ns/1 ps.
// Half clock period value should have precision of upto 3-bits in a case of floating value.

`timescale 1ns/1ps

module spi_clock_generator;

    reg sclk;

    // Initial block to generate a 9 MHz clock
    initial begin
        sclk = 0;

        // Generate a 9 MHz square wave
        forever begin
            #55.556 sclk = ~sclk;
        end
    end

endmodule
