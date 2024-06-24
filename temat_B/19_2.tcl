#zadanie 19
source symul_lib.tcl;

set liczbaWierz 8

set sasiedzi(0) {7 1}
set sasiedzi(1) {0 2}
set sasiedzi(2) {1 3}
set sasiedzi(3) {2 4}
set sasiedzi(4) {3 5}
set sasiedzi(5) {4 6}
set sasiedzi(6) {5 7}
set sasiedzi(7) {6 0}

fiber create $liczbaWierz {
    set leader 0
    set minid $id

    fiber yield;

    dostarcz 1 "$id"
    while {$run} {
        set message [lindex [czytaj 0] 0]
        if {$message<$id} {
            set minid $message
            dostarcz 1 "$message"
        } elseif {$message==$id} {
            set leader 1
            set minid $message
        }
        fiber switchto main;
    }

}
InicjalizacjaAsynch

proc wizualizacja {} {
    _puts { }
    fiber_iterate {_puts "$id: kom0: $kom0 leader?: $leader min ID: $minid"}
}

set licznik 0;

proc egzekucja {liczbaWierz licznik args} {
    set random [expr {int(rand()*[expr $liczbaWierz+1])}];
    for {set i 0} {$i < $liczbaWierz} {incr i} {
        if {$i!=$random && $licznik!=0} {
            fiber switchto $i;
        } elseif {$licznik==0} {
            fiber switchto $i;
        }
    }
    set licznik [expr $licznik + 1];
}

egzekucja $liczbaWierz $licznik; set licznik 1; wizualizacja;

fiber error
