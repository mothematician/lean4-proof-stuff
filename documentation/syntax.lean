/-given an expression `e` of inductive type `Foo`
notation `e.bar` is short hand for `Foo.bar e`
-- easy way to access functions without opening namespace-/

variable (xs : List Nat)

#check List.length xs
#check xs.length