def condfunc (y : Bool) (x : Nat) :=
  if y : false then
    x + 1
  else
    x + 2

#eval condfunc false 5