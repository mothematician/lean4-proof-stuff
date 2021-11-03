-- FUNCTION ABSTRACTION AND EVALUATION

-- `normal lambda`
-- `fun` or `λ` to quickly create function from expression & evaluate it
#check fun (x : Nat) => x + 5   -- Nat → Nat
#check λ (x : Nat) => x + 5     -- λ and fun mean the same thing
#check fun x : Nat => x + 5     -- Nat inferred
#check λ x : Nat => x + 5       -- Nat inferred
#eval (λ x : Nat => x + 5) 11    -- 15

/-lean 3 syntax
#check fun x : nat, x + 5
#check λ x : nat, x + 5
-/


-- `lambda abstraction`: process of creating func from another expression
-- doesnt mean we have to use λ itself
/- suppose i hv variable `x : α` (x is variable of type α) 
    and can construct expression `t : β`
    then the expression `fun (x : α) => t` or `λ (x : α) => t` is object of type `α → β`
    like func from α to β which maps any value x to value t
-/
#check fun x : Nat => fun y : Bool => if not y then x + 1 else x + 2
#check fun (x : Nat) (y : Bool) => if not y then x + 1 else x + 2
#check fun x y => if not y then x + 1 else x + 2   -- Nat → Bool → Nat
/-in last one, the type is inferred from "not y" and "x + 1" since they cna only be bool and nat-/

-- more examples
def f (n : Nat) : String := toString n
def g (s : String) : Bool := s.length > 0

#check fun x : Nat => x
#check fun x : Nat => true     -- Nat → Bool
#check fun x : Nat => g (f x)  -- Nat → Bool
#check fun x => g (f x)        -- Nat → Bool

/-what these funcs really mean:
1. denotes id on Nat
2. denotes constant func that always returns true
3. denotes composition of f and g
4. simpler way to denote composiiton
-/

-- can pass these funcs as parameters by giving them names
-- then can use them in the implementation:
#check fun (g : String → Bool) (f : Nat → String) (x : Nat) => g (f x)
-- (String → Bool) → (Nat → String) → Nat → Bool

-- `more on composition of functions with lambda abstraction`

-- can also pass types as parameters
#check fun (α β γ : Type) (g : β → γ) (f : α → β) (x : α) => g (f x)
/-denotes func that takes 3 types α β γ and 2 funcs, g : β → γ, f : α → β
and returns composition of g and f
manipulating it a bit: -/

-- #check fun (α β γ : Type) (g : β → γ → α) (f : α → β) (x : α) => f (g x)
-- here we see that it shows an error bc the dom and cod don't line up

#check fun (α β γ : Type) (g : β → α) (f : α → β) (h : β → γ) (x : β) => h (f (g x))
-- here we see that it does line up & we've added extra func

/- doing this is much quicker allows us to avoid having to define multiple variables, and functions that are only used once
thus lambda abstraction is even cooler than normal lamba-/


-- `bound variable`: place holder - scope doesn't extend beyong the cod expression
  -- ie `fun x : α => t` x is variable bound to t
-- `alpha equivalent`: expressions that are the same up to renaming of bound varaibles
  -- lean recognizes this equivalence
  -- `fun (b : β) (x : α) => b` is alpha equivalent to `fun (u : β) (z : α) => u`

-- these work as expected idk
#check (fun x : Nat => x) 1     -- Nat
#check (fun x : Nat => true) 1  -- Bool
#eval (fun x : Nat => x) 1     -- 1
#eval (fun x : Nat => true) 1  -- true

def ff (n : Nat) : String := toString n
def gg (s : String) : Bool := s.length > 1

#check ff 0 -- converted to string as defined
#eval ff 0 -- "0" ok
#check gg (ff 0)
#eval gg (ff 0)  
-- BASICALLY this takes ff of 0 which converts to "0", then takes that to bool, where it's True if string length > 1 as we defined

#check (fun (α β γ : Type) (u : β → γ) (v : α → β) (x : α) => u (v x))
  -- fun α β γ u v x => u (v x) : (α β γ : Type) → (β → γ) → (α → β) → α → γ
#check (fun (α β γ : Type) (u : β → γ) (v : α → β) (x : α) => u (v x)) Nat String Bool gg ff 0
  -- Bool
  -- not sure why they put Nat String Bool gg ff 0 at the end tbh - maybe to feed 0 in and show how it progresses thru each of the u v x funcs defined?
    -- seems like it.
    -- note the u v x all satisfy composiiton of the ff and gg
    #eval (fun (α β γ : Type) (u : β → γ) (v : α → β) (x : α) => u (v x)) Nat String Bool gg ff 23

    -- OK NOW I HAVE ANSWER - THE Nat String Bool IS FED INTO THE α β γ : Type
    -- since u (v x)) is the fun we are defining, we need to make sure to input all the required args
    -- check `definitions.lean` for more details
