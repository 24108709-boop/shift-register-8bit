`default_nettype none

module tt_um_shift_register_8bit (
    input  wire [7:0] ui_in,    // Dữ liệu nạp song song (Parallel Data Input)
    output wire [7:0] uo_out,   // Đầu ra dữ liệu 8-bit của thanh ghi
    input  wire [7:0] uio_in,   // uio_in[1:0]: Mode | uio_in[2]: sin_left | uio_in[3]: sin_right
    output wire [7:0] uio_out,  // Không dùng làm output, gán = 0
    output wire [7:0] uio_oe,   // Cấu hình chân uio làm input, gán = 0
    input  wire       ena,      // Tín hiệu cho phép (Enable)
    input  wire       clk,      // Xung đồng hồ (Clock)
    input  wire       rst_n     // Reset tích cực mức thấp (Active-low Reset)
);

    // Gán cố định cho các chân I/O phụ không sử dụng
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Bóc tách các tín hiệu điều khiển từ uio_in
    wire [1:0] mode      = uio_in[1:0]; 
    wire       sin_left  = uio_in[2];   
    wire       sin_right = uio_in[3];   

    // Thanh ghi lưu trữ trạng thái 8-bit
    reg [7:0] reg_data;

    // Gán dữ liệu thanh ghi ra đầu ra chính uo_out
    assign uo_out = reg_data;

    // Mạch logic cập nhật trạng thái theo xung clk và rst_n
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_data <= 8'b00000000;
        end else if (ena) begin
            case (mode)
                2'b00: begin
                    reg_data <= reg_data;                   // Hold (Giữ nguyên)
                end
                2'b01: begin
                    reg_data <= {reg_data[6:0], sin_left};  // Shift Left
                end
                2'b10: begin
                    reg_data <= {sin_right, reg_data[7:1]}; // Shift Right
                end
                2'b11: begin
                    reg_data <= ui_in;                      // Parallel Load
                end
                default: begin
                    reg_data <= reg_data;
                end
            endcase
        end
    end

endmodule