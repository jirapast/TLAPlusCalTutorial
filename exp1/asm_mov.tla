------------------------------ MODULE asm_mov ------------------------------

EXTENDS Integers
CONSTANT DATA
VARIABLES pc, rdi

TypeOk == /\ pc \in {0,1}
          /\ rdi \in {-1} \cup {0,1,2,3,4,5}

Init == /\ pc = 0
        /\ rdi = -1

Next == /\ pc' = 1
        /\ rdi' \in DATA

Spec == Init /\ [][Next]_<<pc, rdi>>

THEOREM Spec => [](TypeOk)

=============================================================================
\* Modification History
\* Last modified Sun Sep 14 17:54:24 ICT 2025 by jiiss
\* Created Sun Sep 14 14:17:09 ICT 2025 by jiiss
