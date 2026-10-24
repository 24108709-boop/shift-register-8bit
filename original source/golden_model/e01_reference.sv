module e01_reference (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       en,
    input  logic [1:0] mode,
    input  logic [7:0] parallel_in,
    input  logic       serial_in,
    output logic [7:0] q_ref
);
    always_ff @(posedge clk) begin
        if (!rst_n)
            q_ref <= 8'h00;
        else if (en) begin
            case (mode)
                2'b00: q_ref <= q_ref;
                2'b01: q_ref <= parallel_in;
                2'b10: q_ref <= {q_ref[6:0],serial_in};
                2'b11: q_ref <= {serial_in,q_ref[7:1]};
                default: q_ref <= q_ref;
            endcase
        end
    end
endmodule
