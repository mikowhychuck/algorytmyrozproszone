source symul_graf_lib.tcl
# drzewo losowe nieukorzenione, 5.11.2019
# + uwaga: tu NIE ma konwencji, że "do parenta przez poł. nr 0" !!
set G [exec ./drzewolosowe01 50]
set EG [lindex $G 1]
set liczbaWierz 0
array unset sasiedzi
foreach e $EG {eval G::kraw $e}
G::pokazGraf
G::rysujGraf