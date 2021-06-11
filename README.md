# SaCriWaB

**Sa**fety **Cri**tical **Wa**tchDog timer and **B**rownn-Out detector
To design an external **watchdog timer** enabled with **Brown out detection** and implement it in  a FPGA. A **Watchdog timer (WDT)** is a hardware subsystem that monitors the operations of the system and generates a system reset in the event of detecting a fault.A **Brown-Oout** of a system  is a partial and temporary reduction in the power supply voltage below the level required for reliable operation.


## Contents

- [Description](#Description)
  - [Design Parameters](#Design-Parameters) 
  - [Hardware & Software](#Hardware-&-Software)
  - [Block diagram](#Block-diagram)
  - [Files Description](#Files-Description)

## Description
A watchdog timer (WDT) is a hardware subsystem that monitors the operations of the system. It generates a system reset in the event of detecting a fault. It consists of a timer circuit and the processor is required to periodically reset the timer.The brown out of a system  is a partial and temporary reduction in the power supply voltage below the level required for reliable operation.By comparing the VCC to a fixed trigger level it can determine if the device needs to be put into reset mode to prevent erratic operation.

## Design Parameters


## Hardware & Software
**Xilinx Vivado** - We used this software for Coding as well as for synthesis and simulation of the verilog code.

**Xilinx Virtex-6 FPGA Board** - It is basically simpler than Xilinx Zynq-7000 board

## Block diagram
![Alt text](https://github.com/rejohnsleebac/SaCriWaB/blob/main/Project%20Report/Block%20diagram.JPG "Block diagram")

## Files Description
1. **Configuration_register.v** configuration register for assigning various registers
2. **downcounter.v** - down counter module
3. **frame_window.v** - frame window module
4. **pattern_comparator.v** - pattern comparator module to check data bus
5. **service_window.v** - service window module
6. **watchdog_top.v** - top module which connects all other modules together
7. **wd_fail_detector.v** - this module detects watchdog fail
8. **testbenches** - all the files in this folder are testbenches for checking their corresponding functionality



