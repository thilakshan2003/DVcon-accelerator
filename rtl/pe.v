module pe #
(
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH  = 32
)
(
    input  wire clk,
    input  wire rst,

    input  wire signed [DATA_WIDTH-1:0] a_in,
    input  wire signed [DATA_WIDTH-1:0] b_in,

    output reg signed [DATA_WIDTH-1:0] a_out,
    output reg signed [DATA_WIDTH-1:0] b_out,

    output reg signed [ACC_WIDTH-1:0] acc
);

    wire signed [(2*DATA_WIDTH)-1:0] mult;

    assign mult = a_in * b_in;

    always @(posedge clk) begin
        if (rst) begin
            a_out <= 0;
            b_out <= 0;
            acc   <= 0;
        end
        else begin
            // Forward data
            a_out <= a_in;
            b_out <= b_in;

            // MAC operation
            acc <= acc + mult;
        end
    end

endmodule