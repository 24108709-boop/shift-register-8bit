# E01 · Bối cảnh ứng dụng



| | |
|---|---|
| Mã đề | **E01** |
| Tên đề | Thanh ghi dịch đa năng 8-bit |
| Nhóm đề | E · Thanh ghi dịch và xử lý chuỗi bit |
| Độ khó | Trung bình (nhẹ) |
| Loại mạch | **Tuần tự** |
| Quy mô ước lượng (Charter) | ~110–160 cell · 1×1 tile |
| Nguồn gốc | Project Charter — E01, mục 1 |

---

## 1. Mục tiêu và bối cảnh ứng dụng

Trích nguyên văn Charter mục 1:

> Phân tích khối số “Thanh ghi dịch đa năng 8-bit” ở mức khối. Bối cảnh ứng dụng: Khối đệm dữ liệu vạn năng trong bo mạch thu thập: nạp song song từ ADC, dịch ra nối tiếp về vi điều khiển.

## 2. Vị trí khối E01 trong hệ thống

```
   ┌──────────────┐      ┌──────────────────────────────┐      ┌──────────────┐
   │  Nguồn tín   │─────▶│      ►►► KHỐI E01 ◄◄◄        │─────▶│  Tầng tiêu   │
   │  hiệu / dữ   │      │  Thanh ghi dịch đa năng 8-bit │      │  thụ kết quả │
   │  liệu vào    │      │  Loại mạch: Tuần tự          │      │              │
   └──────────────┘      └──────────────────────────────┘      └──────────────┘
```

> Sơ đồ chi tiết có chú thích: `03_ARCHITECTURE/system_diagram.md`.

## 3. Phân loại analog / digital / mixed

| Khối | Phân loại | Ghi chú |
|---|---|---|
| Cảm biến / nguồn tín hiệu vật lý (nếu có) | Analog | Đại lượng liên tục |
| Chuyển đổi ADC/DAC (nếu có) | Mixed-signal | Ranh giới analog–số |
| **E01 — Thanh ghi dịch đa năng 8-bit** | **Digital, tuần tự** | Có ô nhớ, hoạt động theo cạnh clock |
| Tầng xử lý phía sau | Digital | Tiêu thụ kết quả của E01 |

Bằng chứng cho dòng phân loại của E01: tổng hợp thật cho **8 flip-flop**
(`06_GDSII/synthesis/synth_stat.txt`).

---

**Truy vết:** yêu cầu sinh từ tài liệu này được đánh số `REQ-E01-0xx` trong
`01_REQUIREMENT/requirements.md`, và truy vết đến bằng chứng trong `07_TRACEABILITY/RTM.csv`.

*Phiên bản: v1.0 · Ngày: 2026-09-24*
