----------------------------- MODULE asm_mov_2 -----------------------------

EXTENDS Integers
CONSTANT DATA
VARIABLE pc, di, ax

TypeOk == /\ pc \in {0,1,2}
          /\ di \in {-1} \cup DATA

Init == /\ pc = 0 
        /\ di = -1
        /\ ax = -1

Next == \/ /\ pc' = 1 
           /\ di' \in DATA
           /\ UNCHANGED  ax
        \/ /\ pc' = 2
           /\ UNCHANGED di
           /\ ax' = di

SPEC == Init /\ [][Next]_<<pc, di, ax>>

=============================================================================
\* Modification History
\* Last modified Sun Sep 14 18:54:12 ICT 2025 by jiiss
\* Created Sun Sep 14 18:37:21 ICT 2025 by jiiss
