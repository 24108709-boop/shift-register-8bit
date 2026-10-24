module e01_explicit_mux (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       en,
    input  logic [1:0] mode,
    input  logic [7:0] parallel_in,
    input  logic       serial_in,
    output logic [7:0] q,
    output logic       serial_out
);
    integer i;
    logic [7:0] d;

    always_comb begin
        for (i = 0; i < 8; i = i + 1) begin
            case (mode)
                2'b00: d[i] = q[i];
                2'b01: d[i] = parallel_in[i];
                2'b10: d[i] = (i == 0) ? serial_in : q[i-1];
                2'b11: d[i] = (i == 7) ? serial_in : q[i+1];
                default: d[i] = q[i];
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n)
            q <= 8'h00;
        else if (en)
            q <= d;
    end

    always_comb begin
        if (mode == 2'b10)
            serial_out = q[7];
        else if (mode == 2'b11)
            serial_out = q[0];
        else
            serial_out = 1'b0;
    end
endmodule
