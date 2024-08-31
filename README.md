# Learning Path for SystemVerilog for Verification : Fundamentals📘

Welcome to the SystemVerilog Learning Path! This guide is designed to help you master SystemVerilog programming step-by-step. Follow the flowchart below to navigate through the key learning areas.

## Learning Path Diagram 🗺️

## Contents
## 1. IDE
## 2. Fundamentals: Procedural Constructs
## 3. Understanding SV Datatypes
## 4. Verification Fundamentals
## 5. Fundamentals of SystemVerilog OOP Constructs
## 6. Randomization
## 7. IPC
## 8. Interface

---
## Section 1 : IDE 
IDE used while learning System Verilog 
1. EDA PLAYGROUND
2. XILINX VIVADO DESIGN SUITE
---
---
## Section 2 : Fundamentals : Procedural constructs
In this section learned about : GLOBAL SIGNALS
1. Initial Block
2. Always Block
3. Aligning edges of the generated clock and reference clock
4. `timescale directive
5. Understanding parameter for generating Clock
### Assignments For Section : 2

### A21
* Assume a system consists of two global signals, resetn and clk. Use an initial block to initialize clk to '0 and resetn to '0. The user must maintain resetn in an active-low state for 60 ns at the start of the simulation and then make it active-high. Assume a timescale of 1 ns/1 ps.

### A22
* Assume a system consists of two global signals, resetn and clk. Use an initial block to initialize clk to '0 and resetn to '0. Generate a 25 MHz square wave waveform for the Signal clk. Assume a timescale of 1 ns/1 ps.

### A23
* Assume a SPI module consists of serial clock signal "sclk". Use an initial block to initialize sclk to '0 and Generate a 9 MHz square wave waveform for the Signal sclk. Assume a timescale of 1 ns/1 ps. Half clock period value should have precision of upto 3-bits in a case of floating value.

### A24
* Write a function capable of generating a square waveform with the help of period(in nSec) and duty cycle(0 to 1). The phase difference is assumed to be 0 for the entire system operation. Verify function behavior by generating waveform for the signal clk with period: 40 nsec and duty cycle: 0.4?
---
---
## Section 3 : Understanding SV Datatypes
In these section learned about Data types :
1. Data type
2. Array
3. Loops for repetitive array
4. Array operations
5. Dynamic Array
6. Queue

### Assignments For Section : 3
### A31
* Assume you have four variables ( a, b,c, and d )  in your testbench top. a and b are of the 8-bit reg type, while c and d are of the integer type. initialize a,b,c, and d to values of 12, 34, 67, and 255 respectively. Add a code to print the values of all the variables after 12 nSec.

### A32
* Create an array capable of storing 10 elements of an unsigned integer. Initialize all the 10 elements to a value equal to the square of the index of that element. for e.g. first element has index no. 0 so initialize it to 0, the second element has index no. 1 so initialize it to 1, the third element has index no. 2 so initialize it to 4, and so on. Verify the code by sending values of all the elements on Console.

### A33
* Create two arrays of reg type capable of storing 15 elements.Use $urandom function to add 15 values to the array. Print the value of all the elements of the array on a single line.

### A34
* Use Dynamic array in Testbench top.
Questions for this assignment
Create a dynamic array capable of storing 7 elements. add a value of multiple of 7 starting from 7 in the array (7, 14, 21 ....49). After 20 nsec Update the size of the dynamic array to 20. Keep existing values of the array as it is and update the rest 13 elements to a multiple of 5 starting from 5. Print Value of the dynamic array after updating all the elements.
Expected result : 7, 14, 21, 28 ..... 49, 5, 10, 15 ..... 65 
systemVerilog implementation

### A35
* Use Queue and Fixed-Size array
Questions for this assignment
Create a Fixed-size array capable of storing 20 elements. Add random values to all the 20 elements by using $urandom function. Now add all the elements of the fixed-size array to the Queue in such a way that the first element of the Fixed-size array should be the last element of the Queue. Print all the elements of both fixed-size array and Queue on Console.
---
---
## Section 4 : Verification Fundamentals

#### 1.Understanding Verification Plan:
* Defines what to test, how to test, and coverage goals.
#### 2.Direct Test vs. Random Constraint Test: 
* Direct tests use specific inputs; random constraint tests explore various scenarios within constraints.
#### 3.Layered Architecture: 
* Organizes verification into unit, integration, and system testing.
#### 4.Individual Components of Testbench: 
* Driver (stimulus), Monitor (observations), Scoreboard (result comparison), Sequencer (test sequencing), and Test (scenario definition).
---
---
## Section 5 : Fundamental of SystemVerilog and OOPS constructs
##### In this Section :
1. Fundamentals of Class
2. Ways to add Method to Class
3. Using Function
4. Using Task
5. Understanding Pass by Reference 
6. Understanding Pass by Value
7. Using Array in function
8. User defined Constructor
9. Multiple argument to Constructor
10. Using task in class
11. Using class in class
12. Scope of Data member 
13. Copying Object
14. Strategies to copy Object
15. Custom method
16. Shallow Copy 
17. Deep Copy
18. Extending Class properties by inheritance
19. Understanding Usage of Super Keyword

### Assignment For Section : 5
### A51
* Create a Class consisting of 3 data members each of unsigned integer type.Initialize them to 45,78, and 90. Use the display function to print the values on the console.

### A52
* Create a function that will perform the multiplication of the two unsigned integer variables. Compare values return by function with the expected result and if both values match send "Test Passed" to Console else send "Test Failed".

### A53
* Questions for this assignment Refer to A53.png Create a task that will generate stimulus for addr , wr, and en signal as mentioned in a waveform of the Instruction tab. Assume address is 6-bit wide while en and wr both are 1-bit wide. The stimulus should be sent on a positive edge of 25 MHz clock signal.

### A54
* Create a function that generate and return 32 values of multiple of 8 (0, 8, 16, 24, 32, 40, 248). Store this value in the local array of the testbench top and also print th value of each element of this array on the console.

### A55
* Assume the class consists of three 8-bit data members a, b, and c.
Create a Custom Constructor that allows the user to update the value of these data members while adding a constructor to the class.Test your code by adding the value of 2, 4, and 56 to a, b and c respectively.

### A56
* Assume class consists of three data members a, b, and c each of size 4-bit. Create a task inside the class that returns the result of the addition of data members.The task must also be capable of sending the value of a, b, c, and result to the console.Verify code for a = 1, b = 2, and c = 4.

### A57
* Create a deep copy of the Generator class. To verify the deep copy code assign value of the copy method to another instance of the generator class in TB top. Print the value of data members in the generator class as well as copied class.Refer Instruction tab for Generator class code.

---
---
## Seection 6 : Randomization
### In SystemVerilog, randomization involves:
#### randc():
* Generates random values.
#### Constraints: 
* Define rules for random values.
#### randomize(): 
* Applies constraints to generate random values that satisfy them.
### Topic covered in this section :
1. Understanding Generator
2. Generating random values with rand
3. randc vs rand
4. Checking randomization is successful : IF ELSE
5. Checking randomization is successful : Assert
6. Care while working with multiple stimuli
7. Adding Constraint : Simple Expression
8. Adding Constraint : Working with ranges
9. External Function and Constraint
10. External Function and Constraint
11. Pre and Post Randomization Methods
12. Understanding randc bucket
13. Things you need to consider while working with RANDC
14. Weighted Distribution P1
15. := vs :/
16. Constraint Operator
17. Implication Operator
18. Equivalence Operator
19. IF ELSE Operator
20. Turning ON and OFF Constraint
21. Understanding FIFO DUT
22. Building Transcation Class

### Assignment for Section : 6
### A61
* Assume generator class consists of three 8-bit data members (x,y, and z).Write a code to generate 20 random values for all the data members at an interval of 20 ns.

### A62
* Assume generator class consists of three 8-bit data members (x,y, and z).Write a code to generate 20 random values for all the data members at an interval of 20 ns. Random values for all data members should range from 0 to 50.

### A63
* Questions for this assignment
For the Generator code mentioned in the Instruction tab, expected values for variable a ranges from 0 to 8, variable b ranges from 0 to 5. Also, add logic to store the number of times randomization failed. Print values of variables during each iteration and error count after generating 20 random values for a and b. Add Constraint Code and Testbench top code to  the Design.

### A64
* Take the help of pseudo-random number generator to generate values for wr and rst signal.
rst should be low for apprx. 30% of time whie wr should be high for apprx. 50% of time. Verify your code for 20 iterations by sending values of both wr and rst on a console.
Generator code is mentioned in the Instruction tab.

### A65
* Generate values between 0 to 7 for addr signal when wr is high and values between 8 to 15 when wr is low.Generator code is mentioned in the Instruction tab.Verify your code for 20 iterations by sending values of both wr and addr on a console.

---
---
## Section 7 : IPC
#### we have covered in this section:
1. Interprocess Communication Mechanism
2. IPC
3. Events
4. @ VS Wait
5. Executing Mulitple Process
6. Multiple Process with Multiple Initial block
7. Multiple Process with FORK JOIN
8. Multiple Process with FORK JOIN P2
9. Demonstration of FORK_JOIN
10. Understanding FORK JOIN_ANY
11. Understanding FORK JOIN_NONE
12. Usage of FORK JOIN in Testbench
13. Understanding Semaphore
14. Understanding Mailbox P1
15. Understanding Mailbox P2
16. Specifying Mailbox with Custom Constructor
17. Sending Transaction data with Mailbox
18. Using Parameterized Mailbox

### Assignment for Section : 7
### A71
* Create two tasks each capable of sending a message to Console at a fixed interval. 
Assume Task1 sends the message "Task 1 Trigger" at an interval of 20 ns while Task2 sends the message "Task 2 Trigger" at an interval of 40 ns. Keep the count of the number of times Task 1 and Task 2 trigger by adding a variable for keeping the track of task execution and incrementing with each trigger. Execute both tasks in parallel till 200 nsec. 
Display the number of times Task 1 and Task 2 executed after 200 ns before calling $finish for stopping the simulation.

### A72
* Code for transaction class is mentioned in the Instruction tab. Write a code to send transaction data between generator and driver. Also, verify the data by printing the value of data members of Generator and Driver.

### A73
* Write a code to send transaction data between generator and driver. Also, verify the data by printing the value of data members of Generator and Driver in each transaction. Execute the code for 10 random transactions.

---
---
## Section 8 : Interfaces
#### we have learned in this section :
1. Interface
2. Adding Interface to Simple RTL
3. Using blocking operator for Interface Variables
4. Using Non-blocking Operator for Interface Variables
5. Why we prefer LOGIC over WIRE and REG in Interface
6. Adding Driver Code to Interface
7. Understanding MODPORT
8. Adding Generator
9. Important Rules
10. Injecting Error
11. Adding Monitor and Scoreboard
12. Tweaking Monitor and Scoreboard Code
13. Adding Simple Scoreboard Model

### Assignment For Section 8
### A81
* Create Transaction, Generator and Driver code for Synchronus 4-bit Multiplier.

### A82
* Create Monitor and Scoreboard Code for Synchronous 4-bit Multiplier. Stimulus is generated in Testbench top so do not add Transaction, Generator, or Driver Code. Also, add the Scoreboard model to compare the response with an expected result.
---
---
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
# UVM For Verification
# 1. Fundamentals
# 2. Projects 
---
---

# Fundamentals
## 1.Reporting Mechanism
### Assignments
### A11
* Send the name of the first RTL that you designed in Verilog with the help of reporting Macro. Do not override the default verbosity. Expected Output : "First RTL : Your_System_Name"
### A12
* Write a code to change the verbosity of the entire verification environment to UVM_DEBUG. To demonstrate successful configuration, print the value of the verbosity level on the console.
### A13
* Override the UVM_WARNING action to make quit_count equal to the number of times UVM_WARNING executes. Write an SV code to send four random messages to a terminal with potential error severity, Simulation must stop as soon as we reach to quit_count of four. Do not use UVM_INFO, UVM_ERROR, UVM_FATAL,
### A14
* Write a TB_TOP Code to send message with ID : CMP1 to console while blocking message with ID : CMP2. Code is mentioned in the Instruction tab. Do not change Component code.
### A15
* Exit Simulation with UVM_WARNING
---
---
## 2. UVM objects
### A21
* Create a class "my_object" by extending the UVM_OBJECT class. Add three logic datatype datamembers "a", "b", and "c" with sizes of 2, 4, and 8 respectively. Generate a random value for all the data members and send the values of the variables to the console by using the print method.
### A22
* Comparing two objects of the class.
---
---
## 3. UVM phases 
## A31
* Demonstrate Start of Elaboration phase executes in Bottom-Up fashion.
---
---
## 4.TLM
## A41
* Send transaction data from COMPA to COMPB with the help of TLM PUT PORT to PUT IMP . Transaction class code is added in Instruction tab. Use UVM core print method to print the values of data members of transaction class.
## A42
* Design an environment consisting of a single producer class "PROD" and three subscribers viz., iz. "SUB1", "SUB2", and "SUB3".
---
---
## 5. Project : Combinational Adder
### A51
* Design UVM testbench to perform verification of 4:1 Mux. Design code of 4:1 Mux is added in the Instruction tab.

---
---
## 6. Project : Sequential Adder
### A61
* Design UVM TB to perform verification of Data flipflop (D-FF). Design code is mentioned in the instruction tab.
---
---

