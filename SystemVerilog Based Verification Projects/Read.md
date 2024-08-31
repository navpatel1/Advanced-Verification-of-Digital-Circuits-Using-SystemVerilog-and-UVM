# SystemVerilog for Verification Projects
---
## Verification Environment for DFF
### D Flip-Flop Basic Operation Test Case

The **"D Flip-Flop Basic Operation"** test case is designed to verify the fundamental functionality of the D flip-flop. This test ensures that the D flip-flop correctly captures and outputs the D input on the rising edge of the clock signal, which is crucial for synchronous digital systems.

### Test Steps
- **Initialization**: The flip-flop is initialized to a known state.
- **Applying Inputs**: Various D input values are applied to the flip-flop.
- **Verifying Output Transitions**: The output of the flip-flop is monitored to ensure it correctly reflects the D input value on the rising edge of the clock.
- **Repetition**: The process is repeated with different D input values to ensure consistent behavior across multiple scenarios.

This test case helps ensure that the D flip-flop operates as expected in capturing and holding data with respect to clock edges, which is essential for reliable operation in digital circuits.

#### Assignment For Section 1
#### A11
* Modify the TB Code to Send Only 1'bx Values for All Transactions

### A21
* The design engineer has modified the D-FF code to handle 1'bx values on the DIN wire. Analyze the modified design code of the D-FF in the instruction to gain a better understanding. Additionally, modify the scoreboard to consider DOUT = 1'b0 as valid when DIN = 1'bx and display "Test Passed".

---
---
## Verification for FIFO
### FIFO Basic Operation Test Case

The **"FIFO Basic Operation"** test case is designed to verify the fundamental functionality of a FIFO (First-In-First-Out) memory. This test case ensures that the FIFO memory correctly stores and retrieves data in accordance with its specified behavior and capacity constraints. 

### Test Steps

1. **Initialization**
   - Set up the FIFO memory to its initial state.
   - Configure the FIFO to ensure it is ready for data operations.

2. **Data Writing**
   - Write a series of data values into the FIFO.
   - Verify that the FIFO correctly accepts and stores these values.

3. **Verification of Data Writing Order**
   - Check that the data values are written in the correct order.
   - Ensure that the FIFO maintains the first-in, first-out order during data write operations.

4. **Data Reading**
   - Read data values from the FIFO.
   - Ensure that the data read matches the data that was written previously.

5. **Verification of Data Reading Order**
   - Confirm that the data is read in the same order as it was written.
   - Verify that the FIFO maintains the first-in, first-out order during data read operations.

6. **Testing Boundary Conditions**
   - **Overflow**: Attempt to write data into the FIFO beyond its capacity to ensure it handles overflow correctly.
   - **Underflow**: Attempt to read data from an empty FIFO to verify it handles underflow conditions appropriately.

### Assignment
### A21
* Add two independent tasks in the driver: one to perform write operations on the FIFO until it becomes full, and another to read back all the data from the FIFO.

-----
----

## Communication Protocol: Verification of Serial Peripheral Interface (SPI)
SPI (Serial Peripheral Interface) is a synchronous serial communication protocol used to transfer data between a master device and one or more peripheral devices. It's commonly used in embedded systems and microcontroller applications for connecting various components, such as sensors, memory, or display devices.

Master-Slave Architecture: SPI operates in a master-slave configuration. The master device controls the communication, while one or more slave devices respond to the master.
### Assignments :
### A31
* Create a testbench environment for validating the SPI interface's ability to transmit data serially immediately when the CS signal goes low. Utilize the negative edge of the SCLK to sample the MOSI signal in order to generate reference data. Codes are added in Instruction tab.

---
---
## Communication Protocol Verification of UART

# UART Verification

## **Objective**

The goal of UART verification is to ensure that the UART module correctly transmits and receives data, adhering to specified protocol rules, including handling of start bits, data bits, parity bits, and stop bits.

### **Key Verification Components**

#### **1. Test Stimulus**

- **Generates different data patterns and scenarios** to drive the UART transmitter and receiver.
- Includes **random data**, **edge cases**, and **protocol-specific sequences**.

#### **2. Scoreboard**

- **Tracks expected vs. actual data** transmitted and received.
- **Checks data integrity**, ensuring the transmitted data matches the received data, including verification of the **parity bit (odd parity)** and correct **stop bit usage**.

#### **3. Monitors**

- **Observes the UART lines (TX/RX)** to capture transmitted data.
- Ensures the **timing and structure** follow the UART protocol.
- **Verifies the presence** of the start bit, 8 data bits, parity bit, and stop bit.

#### **4. Checkers**

- **Logic components** that automatically detect any mismatches or protocol violations.
- Checks for issues such as **incorrect parity** or **framing errors**.

#### **5. Edge Cases**

- Tests different scenarios, including **maximum and minimum baud rates**.
- Handles **erroneous conditions** like break signals.
- Ensures proper behavior **on reset**.

## **Verification Process**

1. **Initialization**: Reset the UART and initialize the testbench components.
2. **Stimulus Application**: Apply test cases covering all functional aspects of the UART, including sending random 8-bit data with enabled odd parity.
3. **Data Capture and Comparison**: Monitors capture the transmitted data and check against expected values using the scoreboard.
4. **Result Analysis**: Collect results and generate reports on any mismatches or protocol violations to ensure the UART module meets its specifications.

### Assignment 
### A41
* Modify the Testbench environment used for the verification of UART to test the operation of the UART transmitter with PARITY and STOP BIT. Add logic in scoreboard to verify that the data on TX pin matches the random 8-bit data applied on the DIN bus by the user.Parity is always enabled and odd type.


---
---

## Communication Protocol Verification of I2C
# I2C Verification

**Objective:**  
The objective of I2C verification is to ensure that the I2C module correctly implements the I2C communication protocol, allowing for reliable data transfer between the master and slave devices. This includes verifying start and stop conditions, data transfer, clock synchronization, and addressing mechanisms.

## Key Verification Components

**1. Test Stimulus**  
- Generates various scenarios to drive the I2C bus, including normal and abnormal conditions.  
- Includes tests for start and stop conditions, data transfer, addressing, and clock synchronization.

**2. Scoreboard**  
- Tracks expected vs. actual data transactions on the I2C bus.  
- Verifies that data integrity is maintained, ensuring transmitted data matches received data across master and slave devices.  
- Checks for acknowledgment signals and verifies correct device addressing.

**3. Monitors**  
- Observes the I2C lines (SDA and SCL) to capture and analyze communication patterns.  
- Ensures correct implementation of start/stop conditions, bit-level timing, data setup and hold times, and clock stretching.  
- Monitors the acknowledge (ACK) and not-acknowledge (NACK) signals to ensure proper handshake.

**4. Checkers**  
- Logic components that automatically detect any protocol violations or mismatches.  
- Check for issues such as missing acknowledgments, incorrect addressing, timing violations, and data corruption.

**5. Edge Cases**  
- Tests include scenarios with bus contention, simultaneous multi-master communications, and error injection (e.g., clock stretching, glitching).  
- Verifies proper behavior under boundary conditions, such as maximum and minimum clock frequencies, and signal noise.

## Verification Process

1. **Initialization**: Reset the I2C bus and initialize the testbench components, including configuring the master and slave devices.
2. **Stimulus Application**: Apply a range of test cases that cover normal operations, boundary conditions, and abnormal scenarios, such as incorrect addressing or unexpected stop conditions.
3. **Data Capture and Comparison**: Use monitors to capture the communication data and check against expected values using the scoreboard. Ensure proper synchronization between SDA and SCL signals.
4. **Result Analysis**: Analyze the results to identify any mismatches or protocol violations. Generate detailed reports to confirm that the I2C module meets all protocol specifications.

---
---

## Bus protocol : Verification of APB_RAM

### 1. Understand Specifications
- **Functionality**: Read/write operations, address decoding, data storage.
- **Interface**: APB signals such as `PCLK`, `PRESETn`, `PSEL`, `PENABLE`, `PWRITE`, `PADDR`, `PWDATA`, `PRDATA`, `PREADY`.

### 2. Create Verification Plan
- **Coverage**: Basic read/write, boundary conditions, error handling.
- **Goals**: Ensure correct operation, protocol adherence, and expected responses.

### 3. Develop Testbench Components
- **Generator**: Creates APB transactions.
- **Driver**: Performs operations on the RAM.
- **Monitor**: Observes and captures RAM responses.
- **Scoreboard**: Compares actual results to expected results.

## 4. Write Test Cases
- **Basic Functionality**: Write and read operations.
- **Boundary Conditions**: Edge address testing.
- **Error Conditions**: Handling invalid addresses and errors.

### 5. Run Simulation
- **Execution**: Perform test cases and observe behavior.
- **Coverage Analysis**: Verify coverage with metrics.

### 6. Analyze Results
- **Verification**: Confirm correct behavior.
- **Debugging**: Resolve any issues using debugging tools.

### 7. Documentation and Reporting
- **Document**: Test cases, results, and coverage.
- **Report**: Summarize findings and recommendations.

### 8. Regression Testing
- **Re-run Tests**: Ensure fixes do not introduce new issues.

---
---
## AXI Interface Verification

### 1. Understand Specifications
- **Functionality**: Read/write operations, address/data bus, handshake signals.
- **Signals**: `AWVALID`, `AWREADY`, `AWADDR`, `WVALID`, `WREADY`, `WDATA`, `ARVALID`, `ARREADY`, `ARADDR`, `RVALID`, `RREADY`, `RDATA`, `BVALID`, `BREADY`.

### 2. Verification Plan
- **Coverage**: Read/write operations, burst types, address alignment, error handling.
- **Scenarios**: Single/burst transactions, different burst types, edge cases.

### 3. Testbench Components
- **Generator**: Creates AXI transactions.
- **Driver**: Sends transactions to AXI interface.
- **Monitor**: Observes AXI signals.
- **Scoreboard**: Compares expected vs. actual results.

### 4. Test Cases
- **Basic**: Simple read/write.
- **Burst**: Various burst lengths/types.
- **Boundary**: Edge address/data.
- **Error**: Protocol error handling.

### 5. Run Simulation
- **Execution**: Execute tests, check AXI behavior.
- **Coverage**: Ensure scenarios are covered.

### 6. Results & Debugging
- **Verify**: Check against specifications.
- **Debug**: Resolve issues using logs/waveforms.

### 7. Documentation
- **Document**: Test cases, results, coverage.
- **Report**: Findings and recommendations.

### 8. Regression Testing
- **Re-run Tests**: Validate after fixes/changes.
---
---
## AHB Memory Verification

### 1. Understand Specifications
- **Functionality**: Read/write operations, address decoding, memory access.
- **Signals**: `HCLK`, `HRESETn`, `HADDR`, `HTRANS`, `HSIZE`, `HBURST`, `HWDATA`, `HRDATA`, `HREADY`, `HRESP`.

### 2. Verification Plan
- **Coverage**: Read/write operations, address alignment, burst types, error handling.
- **Scenarios**: Single/burst transactions, boundary conditions, and protocol compliance.

### 3. Testbench Components
- **Generator**: Creates AHB transactions.
- **Driver**: Sends transactions to the AHB memory.
- **Monitor**: Observes AHB signals and transactions.
- **Scoreboard**: Validates expected vs. actual results.

### 4. Test Cases
- **Basic**: Simple read/write operations.
- **Burst**: Different burst types and lengths.
- **Boundary**: Address and data boundary conditions.
- **Error**: Handle and check for protocol errors.

### 5. Run Simulation
- **Execution**: Execute test cases and observe behavior.
- **Coverage**: Ensure comprehensive scenario coverage.

### 6. Results & Debugging
- **Verify**: Confirm correct operation against specifications.
- **Debug**: Use logs and waveforms to troubleshoot issues.

### 7. Documentation
- **Document**: Test cases, results, coverage, issues.
- **Report**: Summary of findings and recommendations.

### 8. Regression Testing
- **Re-run**: Validate after design changes or fixes.

---
---
# Wishbone Memory Verification

## 1. Understand Specifications
- **Functionality**: Read/write operations, address decoding, memory access.
- **Signals**: `CLK`, `RST`, `ADR`, `DAT`, `WE`, `STB`, `ACK`, `CYC`, `SEL`.

## 2. Verification Plan
- **Coverage**: Read/write operations, address and data width, burst access, error handling.
- **Scenarios**: Single and burst transactions, boundary conditions, protocol compliance.

## 3. Testbench Components
- **Generator**: Creates Wishbone transactions.
- **Driver**: Sends transactions to the Wishbone memory.
- **Monitor**: Observes Wishbone signals and transactions.
- **Scoreboard**: Compares expected vs. actual results.

## 4. Test Cases
- **Basic**: Simple read/write operations.
- **Burst**: Various burst lengths and patterns.
- **Boundary**: Edge cases for addresses and data.
- **Error**: Protocol error handling and invalid transactions.

## 5. Run Simulation
- **Execution**: Run test cases and monitor Wishbone behavior.
- **Coverage**: Verify all functional scenarios are tested.

## 6. Results & Debugging
- **Verify**: Ensure correct operation per specifications.
- **Debug**: Use logs and waveforms to troubleshoot issues.

## 7. Documentation
- **Document**: Test cases, results, coverage, issues encountered.
- **Report**: Summary of findings and recommendations.

## 8. Regression Testing
- **Re-run**: Ensure no new issues after design changes or fixes.
---
---
