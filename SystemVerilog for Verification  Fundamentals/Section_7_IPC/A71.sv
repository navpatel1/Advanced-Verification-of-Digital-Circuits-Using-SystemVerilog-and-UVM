// A71
// module tb;
 
// task example;
// #20;
// $display("example trigger");
// endtask
 
// ..........................
// .........................
 
 
 
// endmodule
// Questions for this assignment
// Create two tasks each capable of sending a message to Console at a fixed interval. 
// Assume Task1 sends the message "Task 1 Trigger" at an interval of 20 ns while Task2 sends the message "Task 2 Trigger" at an interval of 40 ns. Keep the count of the number of times Task 1 and Task 2 trigger by adding a variable for keeping the track of task execution and incrementing with each trigger. Execute both tasks in parallel till 200 nsec. 
// Display the number of times Task 1 and Task 2 executed after 200 ns before calling $finish for stopping the simulation.

module tb;

  // Variables to keep track of task execution counts
  int task1_count;
  int task2_count;

  // Task 1: Sends message every 20 ns
  task task1;
    begin
      task1_count = 0;
      fork
        // Loop to trigger task1 every 20 ns
        forever begin
          #20ns;
          $display("Task 1 Trigger");
          task1_count++;
        end
      join_none
    end
  endtask

  // Task 2: Sends message every 40 ns
  task task2;
    begin
      task2_count = 0;
      fork
        // Loop to trigger task2 every 40 ns
        forever begin
          #40ns;
          $display("Task 2 Trigger");
          task2_count++;
        end
      join_none
    end
  endtask

  initial begin
    // Start the tasks in parallel
    fork
      task1();
      task2();
    join

    // Run for 200 ns
    #200ns;
    
    // Display counts and stop simulation
    $display("Task 1 executed %0d times", task1_count);
    $display("Task 2 executed %0d times", task2_count);
    $finish;
  end

endmodule
