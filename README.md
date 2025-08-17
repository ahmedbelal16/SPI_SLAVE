# 🛰️ SPI Slave with Single-Port RAM (FPGA)

📌 **Project Overview**  
Welcome to the **SPI Slave with Single-Port RAM Project** — a hands-on FPGA implementation of an SPI peripheral using **Verilog HDL**, **QuestaSim**, and the FPGA toolchain. The design implements an SPI Slave that accepts commands and data from an SPI Master, stores data in an on-chip **single-port RAM**, and returns stored data when requested. The project also compares **Gray**, **One-Hot**, and **Sequential** FSM encodings and selects the best encoding based on post-implementation timing.

---

## 🎯 Features
- ✅ SPI Slave interface (`SS_n`, `SCLK`, `MOSI`, `MISO`)  
- ✅ Single-port RAM for storage (byte-addressable)  
- ✅ Supports **WRITE** and **READ** transactions with addressing  
- ✅ FSM control with **Gray / One-Hot / Sequential** encodings (compared)  
- ✅ Testbench & simulation with **QuestaSim** 🧪  
- ✅ Linting with **QuestaLint** for clean RTL ✅  
- ✅ Full FPGA flow — elaboration → synthesis → implementation → bitstream 📦  
- ✅ Chosen encoding: **Gray** (best post-implementation timing) ⏱️

---

## 📂 File Structure
> Update links to your repo files as needed.

| Path | Description |
|---|---|
| [**SPI SLAVE MODULE**] | Top-level SPI slave (protocol decode, FSM, MISO/MOSI handling) |
| `rtl/spi_fsm_gray.v` | FSM (Gray encoded) |
| `rtl/spi_fsm_onehot.v` | FSM (One-Hot encoded) |
| `rtl/spi_fsm_seq.v` | FSM (Sequential encoded) |
| `rtl/spram.v` | Single-port RAM module |
| `rtl/spi_top.v` | Integration wrapper (SPI + RAM + debug signals) |
| `tb/spi_tb.v` | Testbench verifying write/read sequences & edge cases |
| `sim/run.do` | QuestaSim automation script (compile, run, wave setup) |
| `constraints/top.xdc` | Pin & clock constraints (example mapping included) |
| `docs/SPI_SLAVE.pdf` | Final project report (waves, lint, synthesis, implementation) |
| `bitstream/top.bit` | Generated FPGA bitstream (final) |

---

## 🛠️ Implementation Details

### 🖥️ SPI Interface
- `SS_n` — Slave Select (active-low)  
- `SCLK` — Serial clock (Mode 0 default: sample on rising edge)  
- `MOSI` — Master Out, Slave In (commands / addr / data in)  
- `MISO` — Master In, Slave Out (data out)

### 📦 Protocol (example framing)
1. Master asserts `SS_n` low to start a transfer.  
2. Master sends a **COMMAND** (WRITE / READ).  
3. Master sends **ADDRESS** (N bits) for the RAM location.  
4. For WRITE: master sends **DATA**, slave writes to RAM.  
5. For READ: slave shifts out the data from RAM on `MISO`.

### 🔁 FSM (control flow)
- Typical states: `IDLE`, `CHK_CMD`, `WRITE`, `READ_ADDR`, `READ_DATA`  
- Encodings evaluated: **Gray**, **One-Hot**, **Sequential**  
- Final choice: **Gray** encoding — best timing slack after implementation

### 🧠 Memory
- Single-port RAM, synchronous write/read  
- Byte-addressable; depth/width configurable in `spram.v`

---

## 🔍 Debugging & Testing
- **QuestaSim** simulation to validate RTL and functional behavior  
- Waveforms include: `SS_n`, `SCLK`, `MOSI`, `MISO`, FSM state, RAM signals  
- **QuestaLint** static analysis to ensure clean RTL (no critical warnings)  
- Testbench verifies: reset behavior, WRITE → READ flow, and data integrity on `MISO`

---

## 📏 Design Flow (Vivado / ISE for Spartan-6)
1. Create project and add `rtl/` and `constraints/top.xdc`.  
2. Run: **Elaboration → Synthesis → Implementation → Bitstream**.  
3. Check:
   - ✅ No critical warnings in Messages  
   - ✅ Timing constraints met (setup/hold)  
   - ✅ Resource utilization within limits  
4. Compare timing reports for all FSM encodings and pick the best.

---

## 🔌 Example Pinout (update to match your board)
| Signal | Board Mapping (example) |
|---|---|
| `clk` | 100 MHz clock pin (e.g., W5) |
| `rst_n` | Switch 0 |
| `SS_n` | Switch 1 |
| `MOSI` | Switch 2 |
| `MISO` | LED |

---

## 📊 Results Summary

- **FSM encodings compared:** Gray, One-Hot, Sequential  
- **Selected encoding:** **Gray** — highest timing slack after implementation  
- **Lint:** Clean (no critical issues reported by QuestaLint)  
- **Implementation:** Bitstream generated successfully; timing closed for chosen encoding  
- Full report, waveforms, and implementation snapshots are included in `docs/SPI_SLAVE.pdf`.

---

## 🤝 Credits

**Team:** Ahmed Belal, Omar Waleed  
**Supervisor:** Eng. Kareem Waseem

---

## 🚀 TL;DR

FPGA **SPI Slave** + single-port RAM controlled by an FSM. Verified in **QuestaSim**, linted with **QuestaLint**, **Gray** encoding chosen for best timing — bitstream ready for Spartan-6.

```tcl
# from sim/ directory
do run.do
# open wave window and run simulation
