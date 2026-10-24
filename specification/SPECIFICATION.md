# 02_SPECIFICATION: Specialization & Functional Description

## 1. Tổng quan thiết kế (Overview)
- **Tên mô-đun:** tt_um_shift_register_8bit
- **Loại mạch:** Mạch tuần tự (Sequential Circuit)
- **Kích thước dữ liệu:** 8-bit

## 2. Mô tả các chân tín hiệu (Pinout)
| Tên cổng | Hướng | Độ rộng | Mô tả |
| :--- | :---: | :---: | :--- |
| clk | Input | 1 | Xung nhịp đồng bộ (posedge) |
| rst | Input | 1 | Tín hiệu Reset |
| sel | Input | 2 | Mã chọn chế độ |
| d_in | Input | 8 | Dữ liệu vào song song |
| d_out | Output | 8 | Dữ liệu ra song song |

## 3. Bảng chức năng (Function Table)
- sel = 2'b00: HOLD (Giữ nguyên giá trị hiện tại)
- sel = 2'b01: SHIFT LEFT (Dịch trái 1 bit)
- sel = 2'b10: SHIFT RIGHT (Dịch phải 1 bit)
- sel = 2'b11: PARALLEL LOAD (Nạp dữ liệu song song)
