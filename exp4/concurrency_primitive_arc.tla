--------------------- MODULE concurrency_primitives_arc ---------------------

\* 
\* concurrency primitives atomic reference counting (ARC)
\* 

EXTENDS Naturals, Sequences, FiniteSets

VARIABLES 
x, \*x  shared data 
n, \*n  the number of owners of x 
s, \*s  a set of all unique ids of refs to x 
a  \*a  a set of all possible unique ids of refs

Init == /\ x = "writable shared data"
        /\ n = 0 \*the number of owners of x is 0
        /\ a = {1,2,3,4,5} \*assume we have 5 possible unique ids
        /\ s = {}

ResetToInit ==  /\ x' = "writable shared data"
                /\ n' = 0 \*the number of owners of x is 0
                /\ a' = {1,2,3,4,5} \*assume we have 5 possible unique ids
                /\ s' = {} 

AddRef == \E id \in a:
              /\ n' = n + 1
              /\ x' = x \* assume x remains unchange for simplicity
              /\ s' = s \cup {id} 
              /\ a' = a \ {id}

RemoveRef(id) ==    IF n = 0 \/ id \notin s
                    THEN /\ UNCHANGED <<x, n, s, a>>
                    ELSE /\ n' = n -1
                         /\ x' = x
                         /\ s' = s \ {id}
                         /\ a' = a \cup {id}

Next == AddRef \/ \E id \in s: RemoveRef(id)

Spec == Init /\ [][Next]_<<x, n, s, a>>


Inv_1 == n = 0 => s = {} /\ a = {1,2,3,4,5}
Inv_2 == n = 5 => s = {1,2,3,4,5} /\ a = {}
Inv_3 == Cardinality(a) + Cardinality(s) = 5

AllInv == Inv_1 /\ Inv_2 /\ Inv_3

=============================================================================
\* Modification History
\* Last modified Thu Oct 23 17:02:24 ICT 2025 by jiiss
\* Created Thu Oct 23 15:48:24 ICT 2025 by jiiss
