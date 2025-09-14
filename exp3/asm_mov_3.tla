----------------------------- MODULE asm_mov_3 -----------------------------

EXTENDS Integers
CONSTANT DATA
VARIABLE pc, di

TypeOk == /\ pc \in {0,1}
          /\ di  \in 0..10

Init == /\ pc = 0 
        /\ di \in DATA \* read

Next == /\ pc' = 1
        /\ pc = 0
        /\ di' = di + 10 \* modify
        /\ di \in DATA

Spec == Init /\ [][Next]_<<pc, di>>

\* THEOREM Spec => [](TypeOk)

=============================================================================
\* Modification History
\* Last modified Sun Sep 14 19:52:52 ICT 2025 by jiiss
\* Created Sun Sep 14 18:37:21 ICT 2025 by jiiss
