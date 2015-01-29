3 Counter Machine interpreter
=============================

This is an OCaml implementation of the 3 Counter Machine from
Sec.1.3.2 of Plotkin's lecture notes on structural operational
semantics [http://homepages.inf.ed.ac.uk/gdp/publications/SOS.ps].


To build:
---------

    $ make


To run:
-------

To interpret the program tests/test5-double.3cm with input 5, just run:

    $ ./main.byte -input 5 tests/test5-double.3cm 
    Opening file "tests/test5-double.3cm"
    
    Program:
    
      1: zero x 6 else 2
      2: dec x
      3: inc y
      4: inc y
      5: zero x 6 else 2
      6: stop
    
    Running with input 5
    
    Result: 10


There is also an option "-trace" to trace the execution.
