// A24
// Write a function capable of generating a square waveform with the help of period(in nSec) and 
// duty cycle(0 to 1). The phase difference is assumed to be 0 for the entire system operation.
// Verify function behavior by generating waveform for the signal clk with period: 40 nsec and duty cycle: 0.4?

`timescale 1ns/1ps

module square_wave_generator;

    // Signal declaration
    reg clk;

    // Task to generate square waveform
    task generate_waveform(input real period_ns, input real duty_cycle);
        real high_time, low_time;

        high_time = period_ns * duty_cycle;
        low_time = period_ns - high_time;

        forever begin
            clk = 1;
            #(high_time) clk = 0;
            #(low_time);
        end
    endtask

    initial begin
        clk = 0;

        generate_waveform(40.0, 0.4);
    end

endmodule
