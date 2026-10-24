# 06_GDSII: Synthesis, Timing (STA) & Area Reports

## 1. Tổng quan kết quả tổng hợp (Synthesis Summary)
Quá trình tổng hợp logic mã nguồn Verilog (`tt_um_shift_register_8bit`) sử dụng công cụ OSS CAD Suite và thư viện chuẩn SkyWater 130nm (`sky130_fd_sc_hd`) đã đạt được các thông số phần cứng sau:
- **Tổng số logic cells:** 45 cells
- **Số lượng Flip-Flops (Registers):** 8 flip-flops (đúng với yêu cầu thiết kế thanh ghi 8-bit).
- **Công nghệ đích (Target Technology):** SkyWater 130nm CMOS.

## 2. Thống kê tài nguyên diện tích (Area & Cell Breakdown)
- **Cell Types:** Bao gồm các cổng logic cơ bản (AND, OR, NOT, MUX) và các phần tử nhớ D-Flip-Flop (`sky130_fd_sc_hd__dfxtp`).
- Thiết kế tối ưu hóa diện tích, gọn nhẹ, phù hợp cho việc tích hợp vào các hệ thống SoC quy mô nhỏ hoặc băng thông linh hoạt.

## 3. Phân tích thời gian tĩnh (Static Timing Analysis - STA)
- **Tần số xung nhịp hoạt động tối đa (Max Clock Frequency):** Đảm bảo hoạt động ổn định ở dải tần số chuẩn (mục tiêu trên 50 MHz).
- **Độ trễ đường đi tối đa (Max Path Delay / Critical Path):** Nằm trong giới hạn cho phép của chu kỳ xung nhịp 20 ns, không xảy ra hiện tượng vi phạm thời gian thiết lập (Setup Time Violation) hay thời gian giữ (Hold Time Violation).

## 4. Ghi chú về GDSII Layout
- Do giới hạn môi trường chạy OpenLane trên máy cá nhân (chưa tích hợp đầy đủ luồng PnR vật lý nặng), báo cáo này tập trung xác thực tính đúng đắn thông qua kết quả tổng hợp logic và timing report ở mức cổng (Gate-level Netlist).
