# 🔧 UART Verification using UVM

This repository contains a **Universal Asynchronous Receiver Transmitter (UART)** verification environment built using **SystemVerilog** and **UVM**.

---

## 📁 Project Structure

rtl/ # RTL design files for the UART 
sim/ # Simulation files and Makefile 
final.pdf # Project documentation (report) 
UART_Vplan.xlsx # Verification planning spreadsheet

## ⚙️ Features

- UVM-based layered testbench
- Configurable UART parameters:
  - Baud rate, parity, stop bits, data width
- Constrained-random and directed tests
- Functional coverage and assertions
- Scoreboard and self-checking mechanisms
- Support for simulation via `Makefile`

You can customize the test or options in the Makefile.

📄 Files of Interest
rtl/uart_top.v: Top-level UART RTL

rtl/uart_receiver.v, uart_transmitter.v: Core UART modules

sim/Makefile: Build and simulation automation

final.pdf: Report detailing architecture, methodology, and results

UART_Vplan.xlsx: Functional coverage and test planning

📌 Notes
Make sure to have your simulator setup and licenses ready.

The UVM environment assumes standard directory structure and naming conventions.

Some memory coverage dumps (e.g., mem_cov, mem_cov1) are present in the sim folder and may be simulator-generated.
## 🛠️ Tools Used

- Verilog, SystemVerilog, UVM, SVA
- QuestaSim
- Linux Shell Scripting

## 👨‍💻 Author

**Anakh M Nair**  
[LinkedIn](https://www.linkedin.com/in/anakh-m-nair)

---

> This project is part of my VLSI Design and Verification training at Maven Silicon.