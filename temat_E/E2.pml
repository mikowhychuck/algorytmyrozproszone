proctype Node(chan ch0, ch1) {
    
    byte leader = 0;
    byte msg;
    ch1 ! _pid;
    
    end:
    do
    ::  ch0 ? msg ->
            if
            ::  msg == -1   -> leader = 0
            ::  msg <  _pid -> skip                  
            ::  msg >  _pid -> ch1 ! msg          
            ::  msg == _pid -> leader = 1;
                               ch1 ! -1;
                               break
            fi
    od
}

init {

    // tworzenie polaczen:
    chan ab = [1] of { byte };
    chan bc = [1] of { byte };
    chan cd = [1] of { byte };
    chan de = [1] of { byte };
    chan ef = [1] of { byte };
    chan fa = [1] of { byte };
    
    //tutaj robię tak żeby wierzchołki porobiły się w losowej kolejności
    bool control[6] = true;
    do
    ::  control[0] -> atomic { run Node(fa, ab); control[0] =false}
    ::  control[1] -> atomic { run Node(ab, bc); control[1] =false}
    ::  control[2] -> atomic { run Node(bc, cd); control[2] =false}
    ::  control[3] -> atomic { run Node(cd, de); control[3] =false}
    ::  control[4] -> atomic { run Node(de, ef); control[4] =false}
    ::  control[5] -> atomic { run Node(ef, fa); control[5] =false}
    ::  else -> break
    od
}