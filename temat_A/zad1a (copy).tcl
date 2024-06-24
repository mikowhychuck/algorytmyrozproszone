source symul_lib.tcl;

set liczbaWierz 5

set sasiedzi(0) {4 1}
set sasiedzi(1) {0 2}
set sasiedzi(2) {1 3}
set sasiedzi(3) {2 4}
set sasiedzi(4) {3 0}

fiber create $liczbaWierz {
  set leader ?;
  wyslij 0 $id;
  wyslij 1 $id;
  fiber yield;
  while {$run} {
    set x0 $kom0;
    set x1 $kom1;

    if {$kom1!="" && $kom0!=""} {
      if {$kom0 > $kom1} {

        if {$leader==1} {

        } elseif {$kom0==0} {
          wyslij 1 0;
          set leader 0;
        } elseif {$kom0>$id} {
          wyslij 1 $kom0;
        } elseif {$kom0==$id} {
          set leader 1;
          wyslij 0 0;
          wyslij 1 0;
        } elseif {$kom0 < $id} {

        }
        fiber yield;
      } else {
        if {$leader==1} {

        } elseif {$kom1==0} {
          wyslij 0 $kom1;
          set leader 0;
        } elseif {$kom1>$id} {
          wyslij 0 $kom1;
        } elseif {$kom1==$id} {
          set leader 1;
          wyslij 0 0;
          wyslij 1 0;
        } elseif {$kom1 < $id} {

        }
        fiber yield;
      }
    } elseif {$kom0!=""} {
      if {$leader==1} {

      } elseif {$kom0==0} {
        wyslij 1 0;
        set leader 0;
      } elseif {$kom0>$id} {
        wyslij 1 $kom0;
      } elseif {$kom0==$id} {
        set leader 1;
        wyslij 0 0;
        wyslij 1 0;
      } elseif {$kom0 < $id} {

      }
      fiber yield;
    } else {
      set x $kom1;
      if {$leader==1} {

      } elseif {$kom1==0} {
        wyslij 0 $kom1;
        set leader 0;
      } elseif {$kom1>$id} {
        wyslij 0 $kom1;
      } elseif {$kom1==$id} {
        set leader 1;
        wyslij 0 0;
        wyslij 1 0;
      } elseif {$kom1 < $id} {

      }
      fiber yield;
    }
  }
}

Inicjalizacja;

proc wizualizacja {} {
  _puts { }
  fiber_iterate {_puts "$id: kom0: $kom0 kom1: $kom1 leader: $leader"}
}

fiber yield; runda; wizualizacja

fiber error
