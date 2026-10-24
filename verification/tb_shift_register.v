`timescale 1ns / 1ps

module tb_shift_register;

    // Khai báo các tín hiệu kết nối với DUT (Device Under Test)
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    reg       ena;
    reg       clk;
    reg       rst_n;

    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Khởi tạo module thanh ghi dịch 8-bit
    tt_um_shift_register_8bit uut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Tạo xung Clock (chu kỳ 10ns -> tần số 100MHz)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_shift_register.vcd"); // Tạo file lưu dữ liệu dạng sóng
        $dumpvars(0, tb_shift_register);    // Lưu tất cả tín hiệu trong testbench
        // Khởi tạo ban đầu
        clk = 0;
        rst_n = 0;
        ena = 1;
        ui_in = 8'b0;
        uio_in = 8'b0;

        // Giữ reset trong 20ns
        #20;
        rst_n = 1;
        $display("[%0t ns] Reset xong, bắt đầu kiểm tra...", $time);

        // 1. Kiểm tra chức năng Nạp song song (Parallel Load - Mode 11)
        // mode = uio_in[1:0] = 2'b11
        #10;
        ui_in = 8'b10101010;
        uio_in = 2'b11; 
        #10;
        $display("[%0t ns] Mode Parallel Load (11): ui_in = 8b10101010 | uo_out = %b (Mong đợi: 10101010)", $time, uo_out);

        // 2. Kiểm tra chức năng Giữ nguyên (Hold - Mode 00)
        #10;
        uio_in = 2'b00;
        ui_in = 8'b11110000; // Thay đổi ui_in nhưng mạch phải giữ nguyên giá trị cũ
        #10;
        $display("[%0t ns] Mode Hold (00): uo_out = %b (Mong đợi: 10101010)", $time, uo_out);

        // 3. Kiểm tra chức năng Dịch trái (Shift Left - Mode 01)
        // mode = 2'b01, sin_left = uio_in[2] = 1'b1
        #10;
        uio_in = {1'b0, 1'b1, 2'b01}; // sin_left = 1, mode = 01
        #10;
        $display("[%0t ns] Mode Shift Left (01): uo_out = %b (Mong đợi: 01010101)", $time, uo_out);

       // 4. Kiểm tra chức năng Dịch phải (Shift Right - Mode 10)
        // mode = 2'b10, sin_right = uio_in[3] = 1'b0 (hoặc 1'b1 tùy ý)
        #10;
        uio_in = {1'b0, 1'b0, 2'b10}; // sin_right = 0, mode = 10
        #10;
        $display("[%0t ns] Mode Shift Right (10): uo_out = %b (Mong đợi dịch phải 1 bit)", $time, uo_out);

        #20;
        $display("[%0t ns] Hoàn tất mô phỏng kiểm tra!", $time);
        $finish;
    end

endmodule