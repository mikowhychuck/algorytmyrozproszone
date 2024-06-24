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
    set leader ?
    set color ?
    if {$id==0} {
        set leader 1
        set color czerwony
        wyslij 0 niebieski
    } else {
        set leader 0
    }
    fiber yield;
    while {$run} {
        set x [czytaj 1]
        if {$leader==0} {
            if {$x=="niebieski"} {
                set color niebieski
                wyslij 0 czerwony
                fiber yield
            } elseif {$x=="czerwony"} {
                set color czerwony
                wyslij 0 niebieski
                fiber yield
            } else {
                fiber yield
            }
        } else {
            fiber yield
        }

    }
}

Inicjalizacja;

proc wizualizacja {} {
    _puts { }
    fiber_iterate {_puts "$id_los: kom0: $kom0 kom1: $kom1 color: $color leader? $leader"}
}

fiber yield; runda; wizualizacja

fiber error