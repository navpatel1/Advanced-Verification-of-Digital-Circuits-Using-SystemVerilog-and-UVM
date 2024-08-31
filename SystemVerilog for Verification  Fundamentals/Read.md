# Learning Path for SystemVerilog for Verification : Fundamentals📘

Welcome to the SystemVerilog Learning Path! This guide is designed to help you master SystemVerilog programming step-by-step. Follow the flowchart below to navigate through the key learning areas.

## Learning Path Diagram 🗺️

```mermaid
flowchart 
    A --> IDE 
    B --> Fundamentals: Procedural Constructs
    C --> Understanding SV Datatypes
    D --> Verification Fundamentals
    E --> Fundamentals of SystemVerilog OOP Constructs
    F --> Randomization
    G --> IPC
    H --> Interface
```
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





