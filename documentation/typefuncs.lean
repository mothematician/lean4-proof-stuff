-- `def`: for defining all kinds of things: variables, lists, functions
def n : Nat := 0
def b1 : Bool := true
def x := (4,5)
def α : Type := Nat


#check (-5, 4.2, 6)   -- check for type of cartesian product

#eval x.1     -- `a.[nat]`: evaluate for index, ie. x.2
#eval Nat.succ 3 -- succession