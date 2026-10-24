# 03_ARCHITECTURE: Kiến trúc hệ thống & Sơ đồ khối

## 1. Sơ đồ khối (Block Diagram Description)
Mạch thanh ghi dịch đa năng 8-bit (`tt_um_shift_register_8bit`) được xây dựng từ các thành phần chính sau:
- **Khối điều khiển (Control Unit):** Tiếp nhận tín hiệu lựa chọn chế độ `sel[1:0]` để giải mã và điều khiển hướng đi của dữ liệu.
- **Khối lưu trữ tuần tự (Sequential Storage - 8x Flip-Flops):** Gồm 8 D-Flip-Flop kết nối đồng bộ theo chu kỳ xung nhịp `clk` để lưu trữ trạng thái 8-bit của dữ liệu (`d_out`).
- **Mạch chọn kênh kết hợp (Combinational Multiplexers):** Đặt ở đầu vào của mỗi Flip-Flop để quyết định nguồn dữ liệu được nạp vào ở sườn lên tiếp theo của xung nhịp dựa trên chế độ chọn:
  - Giữ nguyên trạng thái cũ (HOLD).
  - Lấy dữ liệu từ bit bên cạnh (SHIFT LEFT / SHIFT RIGHT).
  - Lấy dữ liệu trực tiếp từ cổng nạp song song `d_in` (PARALLEL LOAD).

## 2. Luồng dữ liệu (Data Flow)
1. **Clock (`clk`):** Tất cả các thanh ghi thay đổi trạng thái đồng bộ theo sườn lên (posedge).
2. **Reset (`rst`):** Khi tích cực mức cao, toàn bộ các tầng Flip-Flop được xóa đồng loạt về `0`.
3. **Chuyển đổi dữ liệu:**
   - Khi dịch trái (`sel = 2'b01`), bit thấp nhận giá trị từ ngõ vào nối tiếp bên phải (`s_in_right`), các bit cao dịch dần sang trái.
   - Khi dịch phải (`sel = 2'b10`), bit cao nhận giá trị từ ngõ vào nối tiếp bên trái (`s_in_left`), các bit thấp dịch dần sang phải.
   - Khi nạp song song (`sel = 2'b11`), toàn bộ 8 bit ngõ ra nhận trực tiếp giá trị từ `d_in[7:0]`.
