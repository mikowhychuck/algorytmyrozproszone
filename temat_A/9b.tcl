source symul_lib.tcl;

set liczbaWierz 7

set sasiedzi(0) {6 1}
set sasiedzi(1) {0 2}
set sasiedzi(2) {1 3}
set sasiedzi(3) {2 4}
set sasiedzi(4) {3 5}
set sasiedzi(5) {4 6}
set sasiedzi(6) {5 0}

fiber create $liczbaWierz {
    set leader ?
    set minidlos $id_los
    set maxidlos $id_los
    wyslij 0 $id_los
    fiber yield;
    while {$run} {
        set x [czytaj 1]

        if {$x<$minidlos} {
            set minidlos $x
            wyslij 0 $x
            fiber yield
        } elseif {$x>$maxidlos} {
            set maxidlos $x
            wyslij 0 $x
            fiber yield
        } elseif {$x==$id_los} {
            wyslij 0 $x
            fiber yield
        }
        wyslij 0 $x
        fiber yield
    }
}

Inicjalizacja;

proc wizualizacja {} {
    _puts { }
    fiber_iterate {_puts "$id_los: kom0: $kom0 kom1: $kom1 minid: $minidlos maxid: $maxidlos "}
}

fiber yield; runda; wizualizacja

fiber error