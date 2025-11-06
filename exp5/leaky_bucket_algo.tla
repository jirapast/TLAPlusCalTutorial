------------------------- MODULE leaky_bucket_algo -------------------------
EXTENDS Integers, Naturals, Sequences
VARIABLES size_array, next, first, last, counter

Init ==
    \* /\ size_array \in [1..10 -> (0..10)]
    /\ size_array = <<200,700,500,450,400>>
    /\ next = 0
    /\ first = 0
    /\ last = 0
    /\ counter = 1000

GetNextPacket == 
    /\ UNCHANGED << counter >>
    /\ first' = size_array[1]
    /\ last' =  size_array[Len(size_array)]
    /\  IF first' < last' THEN
        /\ next' = last'    
        /\ size_array' = [i \in 1..(Len(size_array)-1) |-> size_array[i]]
        ELSE
            /\ next' = first'
            /\ size_array' = [i \in 2..Len(size_array) |-> size_array[i]]

Next == 
    IF Len(size_array) > 0 THEN
        IF counter > 0 THEN
            GetNextPacket
        ELSE 
            UNCHANGED << size_array, next, first, last, counter >>
    ELSE 
        UNCHANGED << size_array, next, first, last, counter >>


Spec == Init /\ [][Next]_<<size_array,next,first,last,counter>>
========================
