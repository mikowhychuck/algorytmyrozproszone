source symul_lib.tcl;

set obslugaBitow {
  proc bity x { # postac binarna liczby
    usun0 [binary scan [binary format I $x] B* x; set x]
  }
  proc usun0 x { # usuwa zera poczatkowe z repr bin liczby
    set x [string trimleft $x 0]
    if {$x==""} {set x 0}
    set x
  }
  proc porownanieC {cv cu} { # porownuje 2 kolory, zwraca indeks oraz 2 bity...
  set dlcu [string len $cu]
  set dlcv [string len $cv]
  if {$dlcu<$dlcv} {
  set cu "[string repeat 0 [expr {$dlcv-$dlcu}]]$cu"
}
if {$dlcu>$dlcv} {
  set cv "[string repeat 0 [expr {$dlcu-$dlcv}]]$cv"
}
set dl [string len $cu]
iterate i $dl {
  set i1 [expr {$dl-$i-1}]
  # KONIECZNIE trzeba numerowac bity od prawej gdyz
  # dopisuje sie 0 z lewej i wtedy indeksy by sie zmienialy!
  set bu [string index $cu $i1]
  set bv [string index $cv $i1]
  if {$bu != $bv} {return "$i $bv $bu"}
}
return {-1 ? ?}
}
proc wyrownaj {L x} { # dodaje 0 z lewej do L-bitow
set dl [string len $x]
if {$dl>$L} {error "wyrownaj"}
return "[string repeat "0" [expr {$L-$dl}]]$x"
}
proc bin2dec x { # do 32-bitow
  binary scan [binary form B* [wyrownaj 32 $x]] I y
  set y
}
proc iterate {zm liIter kod} { # wygodna petla
upvar $zm i
for {set i 0} {$i<$liIter} {incr i} {
set e [catch {uplevel $kod} x]
if {$e!=0} {return -code $e $x}
}
}
}
set liczbaWierz 15

set sasiedzi(0) {1 2}
set sasiedzi(1) {0 3 4}
set sasiedzi(2) {0 5 6}
set sasiedzi(3) {1 7 8}
set sasiedzi(4) {1 9 10}
set sasiedzi(5) {2 11 12}
set sasiedzi(6) {2 13 14}
set sasiedzi(7) {3}
set sasiedzi(8) {3}
set sasiedzi(9) {4}
set sasiedzi(10) {4}
set sasiedzi(11) {5}
set sasiedzi(12) {5}
set sasiedzi(13) {6}
set sasiedzi(14) {6}


fiber create $liczbaWierz {
  set parentcolor ?
  set result ?
  set i ?
  set color $id
  set bcolor [bity $color]
  set ireverse ?
  if {$id==0} {
    wyslij 0 $bcolor
    wyslij 1 $bcolor
  } elseif {$stopien > 1} {
    wyslij 1 $bcolor
    wyslij 2 $bcolor
  }
  fiber yield;
  while {$run} {
    if {$kom0!=""} {
      set parentcolor $kom0
    }
    set result [porownanieC $bcolor $parentcolor]
    set i [lindex $result 0]
    set ireverse [expr {[string length $bcolor] - 1 - $i}]
    set parentbit [lindex $result 1]
    set bcolor [string replace $bcolor $i $i $parentbit]
    set color [bin2dec $bcolor]
    if {$id==0} {
      wyslij 0 $bcolor
      wyslij 1 $bcolor
    } elseif {$stopien > 1} {
      wyslij 1 $bcolor
      wyslij 2 $bcolor
    }
    fiber yield;
  }
}

fiber_iterate $obslugaBitow

Inicjalizacja;

proc wizualizacja {} {
  _puts { }
  fiber_iterate {_puts "$id: color: $color ($bcolor) parentcolor: $parentcolor "}
}

fiber yield; runda; wizualizacja

fiber error
