------------------------- MODULE progress_reporting -------------------------

\* this version error: "The operator ProcessSomething required 0 arguments"
\*CONSTANT x, ProcessSomething, PrintProgress
\*VARIABLES num_done
\*
\*Init == /\ num_done = 0 
\*        
\*SpawnThread(i) == /\ ProcessSomething(x)
\*                  /\ num_done' = num_done + 1
\*
\*NextSpawn == \E i \in 1..10: SpawnThread(i)
\*MainThread == /\ PrintProgress(num_done)
\*Next == MainThread \/ NextSpawn



\*This version error: Couldn't resolve infix operator symbol '+'

\*EXTENDS Integers

\*CONSTANT ProcessSomething, PrintProgress, Threads


\*VARIABLES num_done

\*TypeOk == /\ num_done \in Nat \*unknown NAT > EXTENDS Integer
 

\*Init == /\ num_done = 0 /\ num_done \in Nat



\* Nature is required to use Nat
\* FiniteSets is required to use Cardinality
EXTENDS Naturals, FiniteSets
CONSTANT Threads
\* VARIABLES num_done, done
VARIABLES num_done, done, progress

\*to map from thread to bool. the Threads must be enumerated like {1,2,3}. Define it in "model"
TypeOk == 
    /\ num_done \in Nat
    /\ progress \in Nat
    /\ done \in [Threads -> BOOLEAN]
    /\ progress <= Cardinality(Threads)
    /\ progress <= num_done

AllDone == \A t \in Threads: done[t] = TRUE
\* TerminationOk == AllDone => num_done >= 1
TerminationOk == AllDone => num_done >= Cardinality(Threads) /\ progress >= Cardinality(Threads)

Init == 
    /\ num_done = 0 
    /\ progress = 0
    /\ done = [thread \in Threads |-> FALSE ]
        
\* be caution to use "r" in all "t". It must not be the same as "r" in Act(r)
Act(r) == 
    /\ TRUE \* abstract away the spawned thread
    /\ done[r]  = FALSE
    \* /\ done[r]' = TRUE  /* this one is not work. Use except */
    /\ done' = [done EXCEPT ![r] = TRUE]
    /\ num_done' = num_done + 1
    /\ UNCHANGED progress
\*    /\ Print(num_done)

MainThread == 
    /\ progress' = num_done
    /\ UNCHANGED << num_done, done>>
          
Next == MainThread \/ \E r \in Threads: Act(r)

\* Spec == Init /\ [][Next]_<<num_done, done>>
Spec == Init /\ [][Next]_<<num_done, done, progress>>




\*    /\ \A t \in Threads: spawn[t]' = spawn[t]
\*    /\ \A t \in Threads: done = FALSE
\*    /\ \A t \in Threads: done' = TRUE
    \* /\ \A t \in Threads: spawn' = "done" 
    \* /\ \A t \in Threads: spawn' = "yes" 
    \*  dont use spawn[t]' = "done". compare to tcommit.tla
          
\* Spec == Init /\ [][Next]_<<num_done,spawn, done>>
          
\*          /\ \A r \in Threads: spawn[r]' = spawn[r]  \* preserve other threads
            
\*                    /\ num_done' = num_done + 1  \*This version error: Couldn't resolve infix operator symbol '+'


\*Spawn == \A t \in Threads: SpawnedThread(t)
\*Next == \A t \in Threads: SpawnedThread(t)

\*Next == Spawn





\*Spec == Init /\ [][Next]_num_done

\*NextSpawn == \E i \in 1..10: SpawnThread(i)
\*NextSpawn == SpawnThread

\*Next == SpawnThread



\*Next == MainThread
\*MainThread == /\ PrintProgress(num_done)
\*Next == MainThread \/ NextSpawn







=============================================================================
\* Modification History
\* Last modified Sun Nov 02 13:09:14 ICT 2025 by jiiss
\* Created Sat Nov 01 16:54:04 ICT 2025 by jiiss

\*https://marabos.nl/atomics/atomics.html#example-progress-reporting
