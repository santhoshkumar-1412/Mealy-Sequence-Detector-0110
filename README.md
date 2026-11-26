
# Mealy Sequence Detector 0110 using Verilog HDL

<p align="center">
  <b>RTL Design | Mealy Finite State Machine | Functional Verification</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Architecture-Mealy%20FSM-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Simulation-Synopsys%20VCS-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Debugging-Synopsys%20Verdi-purple?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Waveform-VCD-red?style=for-the-badge" />
</p>

---

## 1. Project Overview

This project presents the RTL design and functional verification of a **0110 Sequence Detector** using Verilog Hardware Description Language (HDL).

The sequence detector is implemented using a **Mealy Finite State Machine (FSM)** architecture to detect the occurrence of the binary sequence `0110` in a serial input stream.

The design accepts a single-bit serial input and generates an output HIGH whenever the specified sequence is detected.

The FSM consists of four states representing the progress of sequence detection.

- **A:** Initial state, waiting for the first bit.
- **B:** First bit `0` detected.
- **C:** Sequence `01` detected.
- **D:** Sequence `011` detected.

When the complete sequence `0110` is detected, the output `z` becomes HIGH.

The RTL implementation is simulated using **Synopsys VCS**, while waveform visualization and signal-level debugging are performed using **Synopsys Verdi**.

---

## 2. Design Specifications

| Parameter | Description |
|:---|:---|
| Design Name | Sequence Detector 0110 |
| Design Type | Sequential Logic |
| Architecture | Mealy Finite State Machine |
| Detection Sequence | 0110 |
| Input | Single-bit serial input (`x`) |
| Output | Sequence detection output (`z`) |
| Number of States | 4 |
| State Encoding | Binary Encoding |
| Reset | Active-high asynchronous reset |
| Clock | Positive-edge triggered |
| HDL | Verilog |
| RTL Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |
| Waveform Format | VCD |

---

## 3. Design Methodology

The sequence detector is implemented using a Finite State Machine (FSM).

The FSM continuously monitors the serial input and tracks previously received bits to identify the sequence `0110`.

Unlike a Moore FSM, the output of a Mealy FSM depends on both the current FSM state and the current input.

### 3.1 State Definition

Four states are used to represent the progress of sequence detection.

| State | Binary Encoding | Description |
|:---:|:---:|:---|
| A | 00 | Initial state |
| B | 01 | First bit `0` detected |
| C | 10 | Sequence `01` detected |
| D | 11 | Sequence `011` detected |

The initial state of the sequence detector is A.

### 3.2 State Transition Logic

The state transitions are controlled by the serial input `x`.

| Current State | Input x = 0 | Input x = 1 |
|:---:|:---:|:---:|
| A | B / 0 | A / 0 |
| B | B / 0 | C / 0 |
| C | B / 0 | D / 0 |
| D | B / 1 | A / 0 |

*Transition format: Next State / Output.*

The following conditions are implemented:

- When input `0` is received in state A, the FSM moves to B.
- When input `1` is received in state A, the FSM remains in A.
- When input `0` is received in state B, the FSM remains in B.
- When input `1` is received in state B, the FSM moves to C.
- When input `1` is received in state C, the FSM moves to D.
- When input `0` is received in state C, the FSM moves to B.
- When input `0` is received in state D, the complete sequence `0110` is detected and output `z` becomes HIGH.
- When input `1` is received in state D, the FSM moves to A.

**Note:** The state transition logic supports overlapping sequence detection. After detecting `0110`, the FSM moves to state B when the next input is `0`, preserving the matching suffix `0`.

### 3.3 Mealy FSM State Diagram and Transition Table

The following diagram represents the four-state Mealy FSM architecture used for detecting the binary sequence `0110`.

![Mealy FSM State Diagram](screenshots/mealy_fsm_state_diagram.png)

**Output Conditions:**

| Current State | Input x | Output z |
|:---:|:---:|:---:|
| A | 0 or 1 | 0 |
| B | 0 or 1 | 0 |
| C | 0 or 1 | 0 |
| D | 0 | 1 |
| D | 1 | 0 |

- **State D with input 0:** Indicates successful detection of binary sequence `0110`.
- All other state and input combinations maintain the output LOW.

### 3.4 Output Generation

The sequence detector uses Mealy FSM output logic.

The output depends on both the current FSM state and the serial input.

**Boolean Condition:**

`z = 1` when the current state is D and input `x = 0`.

`z = 0` for all other conditions.

Since this is a Mealy FSM, the output can change immediately when the input changes, without waiting for the next active clock edge.

---

## 4. RTL Module Architecture

The project consists of the following Verilog modules:

| Module | Functionality |
|:---|:---|
| `seq_det_0110` | Implements the Mealy FSM sequence detector |
| `seq_det_0110_tb` | Testbench for functional verification |

### 4.1 Sequence Detector Controller

The main RTL module implements the following operations:

**1. State Register**

- Stores the current FSM state.
- Updates on every positive edge of the clock.
- Uses an active-high asynchronous reset.
- Initializes the FSM to state A.

**2. Next State Logic**

- Determines the next state based on the current state and serial input.
- Implements sequence detection functionality.
- Uses combinational logic with a `case` statement.
- Supports overlapping sequence detection.

**3. Output Logic**

- Generates the sequence detection output `z`.
- Depends on the current FSM state and serial input.
- Implements Mealy FSM output behavior.
- Activates when the FSM is in state D and input `x` is LOW.

---

## 5. Repository Structure

```text
sequence-detector-0110-mealy/
│
├── seq_det_0110_mealy.v
│   └── RTL source code (Mealy FSM implementation)
│
├── seq_det_0110_tb.v
│   └── Functional verification testbench
│
├── screenshots/
│   ├── mealy_fsm_state_diagram.png
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

Generated simulation files such as VCD waveforms, compiled executables, and intermediate simulation directories can be maintained locally rather than committed to GitHub.

---

## 6. Functional Verification

A Verilog testbench is developed to verify the functional behavior of the sequence detector.

The testbench generates a clock signal with a 10 ns period and applies different serial input patterns to verify the detection of the binary sequence `0110`.

The simulation uses `$monitor` to display the input, output, reset, clock, current state, and next state values during execution.

### 6.1 Test Scenarios

| Test Case | Input Sequence | Expected Detection |
|:---:|:---:|:---:|
| TC1 | 0110 | 1 |
| TC2 | 0111 | 0 |
| TC3 | 0100 | 0 |
| TC4 | 0110110 | 1 (overlapping detections) |

### 6.2 Test Case Description

**TC1: Successful Sequence Detection**

- Apply input sequence `0110`.
- The FSM transitions through B, C, and D.
- When input `0` arrives in state D, the complete sequence is detected.
- Expected output: `z = 1`.

**TC2: Sequence Not Detected**

- Apply input sequence `0111`.
- The required sequence `0110` is not present.
- Expected output: `z = 0`.

**TC3: Sequence Not Detected**

- Apply input sequence `0100`.
- The required sequence `0110` is not present.
- Expected output: `z = 0`.

**TC4: Overlapping Sequence Detection**

- Apply input sequence `0110110`.
- The sequence detector identifies repeated occurrences of `0110`.
- The FSM preserves matching bits for subsequent detection.
- Expected detection: `z = 1` whenever the complete sequence is detected.

### 6.3 Testbench Input Sequence

The supplied testbench applies the following serial input sequence after reset:

```verilog
rst = 1;
x = 0;
#10 rst = 0;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#10 x = 0;
#10 x = 1;
#10 x = 1;
#10 x = 0;
#20 $finish;
```

The testbench also includes:

- Clock generation using `always #5 clk = ~clk`.
- Asynchronous reset verification.
- VCD waveform generation.
- `$monitor` for displaying simulation signal values.
- Hierarchical access to the DUT current state and next state.

---

## 7. Simulation Environment

The design is simulated using Synopsys VCS, and waveform analysis is performed using Synopsys Verdi.

### 7.1 Simulation Workflow

```text
       Verilog RTL Design
               |
               v
        Verilog Testbench
               |
               v
         Synopsys VCS
               |
               v
         RTL Simulation
               |
               v
          VCD Database
               |
               v
        Synopsys Verdi
               |
               v
        Waveform Analysis
```

### 7.2 VCS Compilation

Compile the RTL source and testbench using:

```bash
vcs -full64 -debug_access+all \
seq_det_0110_mealy.v \
seq_det_0110_tb.v \
-o simv
```

### 7.3 Execute Simulation

```bash
./simv
```

The simulation executes the testbench and displays the signal transitions using the `$monitor` system task.

### 7.4 VCD Waveform Generation

The following commands are included in the testbench to generate a VCD waveform:

```verilog
initial begin
    $dumpfile("seq_det_0110_mealy.vcd");
    $dumpvars(0,seq_det_0110_tb);
end
```

### 7.5 Open Waveform in Synopsys Verdi

Use the following command to open the generated waveform:

```bash
verdi -vcd seq_det_0110_mealy.vcd &
```

The waveform database can be explored using the Verdi waveform viewer.

---

## 8. Waveform Analysis

Synopsys Verdi is used to inspect and analyze the simulation waveforms.

The waveform screenshot demonstrates the sequence detector simulation using the generated VCD database.

### 8.1 Observed Signals

| Signal | Width | Description |
|:---|:---:|:---|
| `clk` | 1 bit | Clock input |
| `rst` | 1 bit | Active-high reset |
| `x` | 1 bit | Serial data input |
| `z` | 1 bit | Sequence detection output |
| `state` | 2 bits | Current FSM state |
| `next_state` | 2 bits | Next FSM state |

### 8.2 Verdi Simulation Waveform

![Sequence Detector Verdi Waveform](screenshots/verdi_waveform.png)

Waveform analysis helps to:

- Inspect clock and reset behavior.
- Verify serial input transitions.
- Observe FSM state transitions.
- Verify the detection of binary sequence `0110`.
- Check output activation in state D when input is LOW.
- Analyze Mealy FSM output behavior.
- Debug sequential circuit functionality.

---

## 9. Tools and Technologies

| Tool / Technology | Purpose |
|:---|:---|
| Verilog HDL | RTL design implementation |
| Finite State Machine | Controller architecture |
| Mealy FSM | Sequence detection architecture |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| VCD | Value Change Dump waveform format |
| Git | Version control |
| GitHub | Source code management and documentation |

---

## 10. Key Learning Outcomes

Through this project, the following concepts are explored:

- Sequential digital circuit design.
- Finite State Machine architecture.
- Mealy FSM implementation.
- Binary sequence detection.
- State encoding and state transitions.
- Clock and asynchronous reset implementation.
- Combinational next-state logic.
- Mealy FSM output generation.
- Overlapping sequence detection.
- Verilog RTL modeling.
- Testbench development and functional verification.
- RTL simulation using Synopsys VCS.
- Waveform analysis and debugging using Synopsys Verdi.
- VCD waveform generation and inspection.

---

## 11. Future Enhancements

Potential extensions to this project include:

- Implementing a Moore FSM architecture.
- Developing a parameterized sequence detector.
- Supporting multiple sequence detection patterns.
- Implementing a programmable sequence detector.
- Adding detection for longer binary sequences.
- Developing a SystemVerilog testbench.
- Implementing assertions and functional coverage.
- Performing RTL synthesis and hardware area analysis.
- Evaluating timing performance and critical paths.
- Comparing Moore and Mealy FSM implementations.

---

## 12. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Design | VLSI Engineering

- GitHub: [@santhoshkumar-1412](https://github.com/santhoshkumar-1412) 
- LinkedIn: [@santhosh-kumar-n-a](https://linkedin.com/in/santhosh-kumar-n-a-26b72532b)

---

## 13. License

This project is intended for educational and learning purposes.

You are welcome to explore, modify, and extend the implementation with appropriate attribution.

---

<p align="center">
  <b>Designed with Verilog HDL | Simulated with Synopsys VCS | Debugged with Synopsys Verdi</b>
</p>

<p align="center">
  ⭐ If you find this project useful, consider starring the repository!
</p>

---

## GitHub Topics

verilog · verilog-hdl · sequence-detector · 0110-sequence-detector · finite-state-machine · fsm-design · mealy-fsm · rtl-design · vlsi · digital-design · sequential-logic · synopsys-vcs · synopsys-verdi · rtl-verification · asic-design · hardware-design
