-- Lean has first-class functions.

-- functions: can take in two or more args
-- args: each can also be arbitrary/anonymous functions itself - ie '(f : Nat → Nat)'
def twice (f : Nat → Nat) (a : Nat) :=
  f (f a)

-- `fun` can be used to declare anonymous funcs
-- alternatively, just simply use `.` to denote the input. it is 'syntax sugar'
-- good for defining simply anonymous funcs
#eval twice (fun x => x + 2) 6
#eval twice (. * 5) 5


-- theorems: can prove theorems about the functions
theorem twiceAdd2 (a : Nat) : twice (fun x => x + 3) a = a + 6 := rfl
