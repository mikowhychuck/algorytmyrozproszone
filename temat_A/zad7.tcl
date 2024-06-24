## Jednrodny LE w ringu
#
source symul_lib.tcl; # ladowanie symulatora

# cykl na 20 wierzcholkach
#
set liczbaWierz 20
iterate i $liczbaWierz {
    let i1 $i-1; if {$i1==-1} {let i1 $liczbaWierz-1}
    let i2 $i+1; if {$i2==$liczbaWierz} {let i2 0}
    set sasiedzi($i) "$i1 $i2"
}

fiber create $liczbaWierz {
    wyslij 0 $id_los
    set leader ?
    while {$run} {

    }
}

Inicjalizacja; # koniecznie trzeba to wywolac!!!

# ... do tego miejsca mozna wszystko wykonac

set_run 0; fiber yield; runda; set_run 1; fiber delete; set licznikKom 0
# usuwanie fiberow
set_run 0; fiber yield; runda; set_run 1; fiber restart; set licznikKom 0
# restart kodu fiberow
fiber error

fiber yield; runda; set licznikKom; wizualizacja;


# tworzenie id_los ze zbioru 0..19
#
proc ciag n {
    iterate i $n {lappend _ $i}; return $_
}
proc permutacjaLosowa {} {
    global perm
    set n [llength $perm]
    for {set i [expr {$n-1}]} {$i>=0} {incr i -1} {
        set k [expr round($i*rand())]
        # zamiana k-tego i i-tego elem
        set e [lindex $perm $k]
        lset perm $k [lindex $perm $i]
        lset perm $i $e
    }
}
set perm [ciag $liczbaWierz]

permutacjaLosowa; set perm

iterate i $liczbaWierz {
    fiber_eval $i "set id_los [lindex $perm $i]"
}

proc wizualizacja {} {
    _puts { }
    fiber_iterate {_puts "$id_los: kom0: $kom0 kom1: $kom1 leader?: $leader"}
}

# inne proc pomocnicze
#
proc 2dopotegi x {expr {round(pow(2,$x))}}
2dopotegi 5