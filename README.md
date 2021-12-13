USAGE
-------------------------------------------------------------------------------------------

```git clone https://github.com/greg998/push_swap_tester.git && cd push_swap_tester```

bash test.sh `stack size` `number of tests`

default range is [-2147483648, 2147483647]

OR

bash test.sh `stack size` `number of tests` `range`

[-range -1, range]

OR
 
bash test.sh `stack size` `number of tests` `range` `valg`

to detect valgrind errors + 0 leak (valgrind logs save in valgrind_log folder)

CLEAN
-------------------------------------------------------------------------------------------

all input/output files in test_files

rm -rf test_files valgrind_log
