module e01_core (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       en,
    input  logic [1:0] mode,
    input  logic [7:0] parallel_in,
    input  logic       serial_in,
    output logic [7:0] q,
    output logic       serial_out
);
    localparam logic [1:0] HOLD  = 2'b00;
    localparam logic [1:0] LOAD  = 2'b01;
    localparam logic [1:0] LEFT  = 2'b10;
    localparam logic [1:0] RIGHT = 2'b11;

    logic [7:0] q_next;

    always_comb begin
        unique case (mode)
            LOAD:  q_next = parallel_in;
            LEFT:  q_next = {q[6:0], serial_in};
            RIGHT: q_next = {serial_in, q[7:1]};
            default: q_next = q;
        endcase
    end

    always_ff @(posedge clk) begin
        if (!rst_n)
            q <= 8'h00;
        else if (en)
            q <= q_next;
    end

    always_comb begin
        case (mode)
            LEFT:  serial_out = q[7];
            RIGHT: serial_out = q[0];
            default: serial_out = 1'b0;
        endcase
    end
endmodule
