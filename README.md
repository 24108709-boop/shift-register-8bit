# 8-bit Universal Shift Register for Tiny Tapeout

## Overview
This project implements an **8-bit Universal Shift Register** in VerilogHDL for the Tiny Tapeout project. 
The design supports four main operational modes controlled via mode selection bits.

## Features & Modes
The operational mode is set using `uio_in[1:0]`:

| `uio_in[1:0]` | Mode | Description |
|---|---|---|
| `2'b00` | **Hold** | Retains current register state |
| `2'b01` | **Shift Left** | Shifts data left, inserts `sin_left` (`uio_in[2]`) at LSB |
| `2'b10` | **Shift Right** | Shifts data right, inserts `sin_right` (`uio_in[3]`) at MSB |
| `2'b11` | **Parallel Load** | Loads 8-bit data directly from `ui_in[7:0]` |

## Pinout Assignment
* **Inputs (`ui_in[7:0]`)**: 8-bit parallel data inputs.
* **Outputs (`uo_out[7:0]`)**: 8-bit register outputs.
* **Bi-directional Pins (`uio_in`)**:
  * `uio_in[1:0]`: Mode select bits (`Mode[1:0]`).
  * `uio_in[2]`: Serial input left (`sin_left`).
  * `uio_in[3]`: Serial input right (`sin_right`).
* **Control**:
  * `clk`: Clock signal.
  * `rst_n`: Active-low asynchronous reset.
  * `ena`: Enable signal.

## How to Simulate
To run functional verification using Icarus Verilog:

```bash
iverilog -g2012 -o sim_out tt_um_shift_register_8bit.v tb_shift_register.v
vvp sim_out