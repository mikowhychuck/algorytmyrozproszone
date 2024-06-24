source symul_lib.tcl;

set liczbaWierz 5

set sasiedzi(0) {4 1}
set sasiedzi(1) {0 2}
set sasiedzi(2) {1 3}
set sasiedzi(3) {2 4}
set sasiedzi(4) {3 0}

fiber create $liczbaWierz {
  wyslij 0 $id_los
  set leader ?
  while {$run} {
    if {$kom(1)!=""} {
      if {$kom(1)>$id_los} {
        set leader 0
        wyslij 0 $kom1
      } elseif {$kom(1)<$id_los} {
        fiber yield
      } elseif {$kom(1)==$id_los} {
        set leader 1
        _puts "$id_los jest leaderem"
      }
      fiber yield;
    }
    fiber yield;
  }
}

Inicjalizacja;

proc wizualizacja {} {
  _puts { }
  fiber_iterate {_puts "$id_los: kom0: $kom0 kom1: $kom1 leader?: $leader"}
}

fiber yield; runda; wizualizacja

fiber error
