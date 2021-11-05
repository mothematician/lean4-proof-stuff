/- CONJUNCTION -/ 
variable (p q : Prop)

-- `and.intro h1 h2` builds proof of `p ∧ q` using proofs `h1 : p` and `h2 : p`
  -- is described as the AND-INTRODUCTION rule\
  example (hp : p) (hq : q) : p ∧ q := And.intro hp hq
  #check fun (hp : p) (hq : q) => And.intro hp hq

-- `example` command states a theorem w/o naming or storing permanently - convinient for illustration

/-left and right AND-ELIMINATION rules-/
  -- `and.left h` creates proof of `p` from proof `h : p ∧ q`
  -- `and.right h` is proof of `q`
    example (h : p ∧ q) : p := And.left h
    example (h : p ∧ q) : q := And.right h 

    example (h : p ∧ q) : q ∧ p :=
    And.intro (And.right h) (And.left h)

-- note: and-introduction and end-elimination are similar to pairing and projection operations for cartesian product. 
-- difference is given `hp : p` and `hq : q`:
  -- `And.intro hp hq` has type `p ∧ q : Prop`
  -- `Prod hp hq` has type `p × q : Type`
-- similarity between ∧ and × is another instance of the Curry-Howard isomorphism tho treated separatedly in Lean.

-- certain types in lean are STRUCTURES: defined w single conanical CONSTRUCTOR which builds an element of the type from a sequence of suitable arguments
  -- ie. For every `p q : Prop`, `p ∧ q` is an example 
    -- canonical way to construct is to apply `And.intro` to suitable args `hp : p` amd `hq : q`
    -- lean lets us use anonymous constructor notation notation `⟨arg1, arg2, ...⟩` when relevant type is inductive type and can be inferred from context
    -- in particular, can often write `⟨hp, hq⟩` instead of `And.intro hp hq`
    variable (hp : p) (hq : q)
    #check (⟨hp, hq⟩ : p ∧ q)

