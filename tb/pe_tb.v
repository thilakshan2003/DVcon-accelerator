`timescale 1ns/1ps

module pe_tb;

    parameter DATA_WIDTH = 8;
    parameter ACC_WIDTH  = 32;

    reg clk;
    reg rst;

    reg signed [DATA_WIDTH-1:0] a_in;
    reg signed [DATA_WIDTH-1:0] b_in;

    wire signed [DATA_WIDTH-1:0] a_out;
    wire signed [DATA_WIDTH-1:0] b_out;

    wire signed [ACC_WIDTH-1:0] acc;

    pe #(
        .DATA_WIDTH(DATA_WIDTH),
        .ACC_WIDTH(ACC_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .a_in(a_in),
        .b_in(b_in),
        .a_out(a_out),
        .b_out(b_out),
        .acc(acc)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        a_in = 0;
        b_in = 0;

        #10;
        rst = 0;

        // Cycle 1
        a_in = 2;
        b_in = 3;

        #10;

        // Cycle 2
        a_in = 4;
        b_in = 5;

        #10;

        // Cycle 3
        a_in = -1;
        b_in = 8;

        #10;

        // Stop
        $finish;
    end

    initial begin
        $monitor(
            "t=%0t a=%0d b=%0d acc=%0d",
            $time,
            a_in,
            b_in,
            acc
        );
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, pe_tb);
    end

endmodule