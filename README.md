# VHDL Design of a Single Cycle Processor - Part 1


## Phase 1 Overview
This phase involves the design, implementation, and simulation of:
1. An **Arithmetic Logic Unit (ALU)** for performing arithmetic and logical operations.
2. A **Register File (RF)**, containing 32 registers with read and write functionalities.

Both components are implemented using VHDL, with simulation conducted using Xilinx ISE or Vivado.

---

## Phase 1 Objectives
1. **Design** the ALU and RF using VHDL.
2. **Simulate** the components to verify their functionality.
3. **Add Delays** in signals for timing simulation in VHDL.

---

## Component Details

### Part A: Arithmetic Logic Unit (ALU)

#### ALU Specifications
The ALU performs the following operations on 32-bit operands in 2's complement format:

| Code (Op) | Operation | Result        |
|-----------|-----------|---------------|
| `0000`    | Addition  | `Out = A + B` |
| `0001`    | Subtraction | `Out = A - B` |
| `0010`    | Logical AND | `Out = A & B` |
| `0011`    | Logical OR | `Out = A | B` |
| `0100`    | Invert A | `Out = !A` |
| `0101`    | NAND | `Out = !(A & B)` |
| `0110`    | NOR | `Out = !(A | B)` |
| `1000`    | Arithmetic Shift Right | `Out = (int) A >> 1` |
| `1001`    | Logical Shift Right | `Out = (unsigned int) A >> 1` |
| `1010`    | Logical Shift Left | `Out = A << 1` |
| `1100`    | Rotate Left | Rotate `A` left by 1 position |
| `1101`    | Rotate Right | Rotate `A` right by 1 position |

**Inputs and Outputs:**

| Signal | Type (Width) | Description |
|--------|--------------|-------------|
| `A`    | Input (32 bits) | First operand in 2's complement |
| `B`    | Input (32 bits) | Second operand in 2's complement |
| `Op`   | Input (4 bits) | Operation code |
| `Out`  | Output (32 bits) | Result in 2's complement |
| `Zero` | Output (1 bit) | Set if result is zero |
| `Cout` | Output (1 bit) | Set if carry out occurs |
| `Ovf`  | Output (1 bit) | Set if overflow occurs |

#### Implementation Steps for ALU
1. **VHDL Coding**: Use Behavioral VHDL for operations, e.g., `+` for addition, `-` for subtraction. Use standard VHDL packages:
   - `ieee.std_logic_1164.all`
   - `ieee.numeric_std.all`
2. **Signal Delay**: Add a delay of 10ns to the ALU output using `after` keyword.
3. **Output Signals**:
   - `Zero` should be set when `Out` equals zero.
   - `Cout` and `Ovf` conditions depend on the result of arithmetic operations; ensure proper test cases in simulation to verify correct behavior.
4. **Simulation**: Test all operations in Xilinx to validate functionality under various input conditions.

---

### Part B: Register File (RF)

#### B1. 32-bit Register
Design a 32-bit register with the following signals:

| Signal | Type (Width) | Description |
|--------|--------------|-------------|
| `CLK`  | Input (1 bit) | Clock |
| `RST`  | Input (1 bit) | Reset |
| `Datain` | Input (32 bits) | Data input |
| `WE`   | Input (1 bit) | Write enable |
| `Dataout` | Output (32 bits) | Data output (delayed by 10ns) |

- **Note**: `Dataout` changes 10ns after the positive clock edge.

#### B2. Register File (RF) Design
The RF consists of 32 32-bit registers with two read ports and one write port.

**Interface Signals:**

| Signal | Type (Width) | Description |
|--------|--------------|-------------|
| `Ard1` | Input (5 bits) | Address for first read register |
| `Ard2` | Input (5 bits) | Address for second read register |
| `Awr`  | Input (5 bits) | Address for write register |
| `Dout1` | Output (32 bits) | Data from first read register |
| `Dout2` | Output (32 bits) | Data from second read register |
| `Din`  | Input (32 bits) | Data for write operation |
| `WrEn` | Input (1 bit) | Write enable |
| `Clk`  | Input (1 bit) | Clock |
| `Rst`  | Input (1 bit) | Reset (optional) |

#### Implementation Steps for RF
1. **Register Array**: Create 32 registers using the `for-generate` VHDL construct.
2. **Continuous Read**: The RF continuously reads from the addresses in `Ard1` and `Ard2` without a read enable.
3. **Combinational Logic**: Ensure combinational elements (e.g., multiplexers) have a delay of 10ns. AND gates should have a 2ns delay.
4. **Register R0**: In MIPS architecture, R0 is always zero. Modify the design to prevent any write to R0.

#### Simulation of RF
1. Test the RF in Xilinx with various input values.
2. Set the clock period (`CLK`) to at least 100ns.
3. Verify all read and write functionalities.

---

## Simulation Guidelines
1. **Testbench**: Use a testbench for both ALU and RF in Xilinx to ensure the correctness of each operation.
2. **ALU Testing**: Check all operation codes and verify output, Zero, Cout, and Ovf signals.
3. **RF Testing**: Use various addresses and data values to verify reading and writing from registers, especially for R0.

---

## Additional Information
- **Clock Period**: Minimum 100ns for RF and ALU testing.
- **VHDL Packages**: Recommended packages include:
  - `ieee.std_logic_1164.all`
  - `ieee.numeric_std.all`
  - `ieee.std_logic_unsigned.all`
  - `ieee.std_logic_signed.all`

## Phase 2 Overview

This project involves the design and implementation of a non-pipelined processor based on a subset of the CHARIS (CHAnia Risc Instruction Set) Instruction Set Architecture (ISA). The main objectives include defining the ISA, designing various stages of the datapath, and creating a working memory model.

## Phase 2 Objectives


This project implements a non-pipelined processor based on a subset of the CHARIS (CHAnia Risc Instruction Set) Instruction Set Architecture (ISA). The main goals are to define the ISA, design various stages of the datapath, and create a functional memory model.

## Table of Contents

- [Objectives](#objectives)
- [Memory Architecture](#memory-architecture)
- [Implementation Steps](#implementation-steps)
- [Testing and Verification](#testing-and-verification)




## Objectives

1. **Define the Instruction Set Architecture (ISA)**:
   - Design a processor with 32 registers (32 bits each), where R0 is always zero.
   - Implement 32-bit wide instructions with specific fields.
   - Support for arithmetic, logical, branching, and memory operations.

2. **Design Stages**:
   - **Instruction Fetch Stage (IF)**: Retrieve instructions from memory using a Program Counter (PC).
   - **Instruction Decode Stage (DEC)**: Decode instructions to generate control signals.
   - **Execution Stage (EX)**: Execute operations using an ALU.
   - **Memory Access Stage (MEM)**: Handle data read and write operations.

## Memory Architecture

- **Memory Size**: 2048 x 32 bits
- **Segments**:
  - **TEXT Segment**: Starts at address `0x000` for storing instructions.
  - **DATA Segment**: Starts at address `0x400` for storing data.
- **Interface Signals**:
  - Clock signal (`clk`)
  - Instruction address (`inst_addr`)
  - Instruction output (`inst_dout`)
  - Data write enable (`data_we`)
  - Data address (`data_addr`)
  - Data input (`data_din`)
  - Data output (`data_dout`)

## Implementation Steps

1. **Study Instruction Encoding**: Analyze encoding for easy decoding and signal generation.
2. **Design the Memory**: Implement a RAM module using provided VHDL code, initialized from a `rom.data` file.
3. **Instruction Fetch Stage (IF)**: Create `IFSTAGE.vhd` for instruction fetching, connecting to the RAM module.
4. **Instruction Decode Stage (DEC)**: Develop `DECSTAGE.vhd` for decoding instructions and managing register access.
5. **Execution and Memory Access Stages**: Integrate the ALU and finalize connections for complete execution.

## Testing and Verification

- **Testbenches**: Create testbenches for each stage (IF, DEC, EX, MEM) to verify functionality.
- **Simulation**: Run simulations to confirm the correctness of instruction processing.

## Phase 3 Overview

This project focuses on the design and implementation of a single-cycle processor. The goal of Phase 3 is to complete and verify the datapath, create a control unit that generates control signals, and establish communication between the datapath and control unit.

## Table of Contents

- [Purpose of Phase 3](#purpose-of-phase-3)
- [Execution Steps](#execution-steps)
- [Signal Monitoring](#signal-monitoring)
- [Testing](#testing)

## Purpose of Phase 3

The main objectives of this phase are as follows:

1. **Complete and Verify Datapath**: Finalize the datapath design, integrating the IF, DEC, EX, and MEM stages, and collect all necessary control signals.
2. **Control Unit Development**: Implement the control unit that will produce the required control signals for each instruction.
3. **Memory Integration**: Create a common memory module shared between the IF and MEM stages, ensuring proper communication.
4. **Testing Framework**: Develop reference programs and testbenches to verify the functionality of the datapath and control unit.

## Execution Steps

1. **Implement Datapath**: Write the VHDL code for the datapath (DATAPATH.vhd) that connects the IF, DEC, EX, and MEM stages. Collect all control signals in the interface.
2. **Common Memory Module**: Create a unified RAM module (not within DATAPATH.vhd) that interfaces with both IF and MEM stages, facilitating necessary communications.
3. **Reference Programs**: Develop your own reference programs (rom.data files) and the corresponding testbenches to generate control signals for verifying the datapath's functionality. Port map the memory module in each testbench.
4. **Instruction Verification**: Use provided reference programs to verify the processor's functionality by encoding commands in binary to create the corresponding rom.data files.
5. **Control Unit Implementation**: Write the VHDL code for the control unit (CONTROL.vhd) to generate the correct control signals for each instruction.
6. **Control Unit Testing**: Create a testbench for the control unit to validate its functionality. Include all supported instructions in the order specified in the provided documentation.
7. **Top Level Module**: Implement the top-level VHDL code for the single-cycle processor (PROC_SC.vhd), incorporating three components (port map): datapath, control, and the common memory module.
8. **Circuit Testing**: In the testbench, set Reset = '1' for a few cycles, then set Reset = '0' to begin execution from address 0.

## Signal Monitoring

To effectively monitor the simulation for Phase 3, prepare a .wcfg file with at least the following signals in the specified order:

- Reset
- Clk
- Instruction
- PC
- PC_LdEn
- RF_WrEn
- RF_ADDRESS_WRITE
- RF_WrData_Sel
- ALU_func
- ALU_zero
- MEM_WrEn
- Registers r3, r5, r10, r16
- 5 memory locations pertaining to the DATA segment starting from byte address 0x400 (1024 in decimal)

Note: Display multi-bit values in HEX or DEC as appropriate for clarity, especially for PC values, operation results, and memory addresses.

## Testing

- Ensure thorough testing using the provided reference programs to confirm the correct operation of the datapath and control unit. 
- Develop detailed testbenches that thoroughly exercise all features of your processor design.

# VHDL Conversion of a Single Cycle Processor to Multicycle Processor - Part 2

## Overview

This project involves the conversion of the single-cycle processor designed in Assignment #1 into a multi-cycle processor. The goal of Phase 4 is to enhance the processor's architecture by implementing a multi-cycle datapath and control unit.

## Table of Contents

- [Purpose of Phase 4](#purpose-of-phase-4)
- [Prerequisites](#prerequisites)
- [Execution Steps](#execution-steps)
- [Testing](#testing)

## Purpose of Phase 4

The main objectives of this phase include:

1. **Datapath Modification**: Transform the single-cycle processor datapath into a multi-cycle datapath by adding registers where necessary to hold signal values between stages.
2. **Control Unit Design**: Design and implement a control unit as a Finite State Machine (FSM) to manage instruction execution flow and generate the required control signals during each clock cycle.
3. **Integration and Validation**: Connect the datapath with the control unit to fully implement the multi-cycle processor and validate the design using reference programs.

## Prerequisites

- Functional design of a single-cycle processor from Assignment #1.
- Understanding of VHDL and digital design principles.

## Execution Steps

I) **Datapath Conversion**:  
   - Modify the single-cycle datapath from Assignment #1 to create a multi-cycle datapath (named `DATAPATH_MC.vhd`).
   - Add registers between stages as needed to retain values produced in one stage for use in subsequent stages. Make additional design changes as deemed necessary.

II) **Control Unit Implementation**:  
   - Design a control unit as a Finite State Machine (FSM) that controls the execution flow of each instruction by generating the required control signals for each clock cycle.
   - The FSM should take the instruction (opcode) and potentially flags (such as Zero) as input, and output all control signals required by the datapath.
   - Remove the previous control unit implemented for the single-cycle processor, and name the new FSM `CONTROL_MC.vhd`.

III) **Integration and Verification**:  
   - Connect the datapath to the control unit to realize the full functionality of the multi-cycle processor. The main memory should be located outside of this module, and name the resulting file `PROCESSOR_MC.vhd`.
   - Validate your design using the reference programs from Assignment #1 and create at least one additional reference program that includes all instructions from the Instruction Set Architecture (ISA).

## Testing

- Confirm the correctness of your design by executing the reference programs from Assignment #1.
- Additionally, develop and execute at least one original reference program that tests all the ISA instructions.
