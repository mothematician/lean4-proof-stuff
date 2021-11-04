/-
one strat for proving assertions about objects in dtt is to
-- layer assertion language and proof langauge on top of definition language

but this not necesary as dtt is expressive and flexible
-- we can represent assertions and proofs in same general framework
-/

-- `prop` to represent propositions, introduce constructors (to build new props)
  def Implies (p q : Prop) : Prop := p → q
  #check And     -- Prop → Prop → Prop
  #check Or      -- Prop → Prop → Prop
  #check Not     -- Prop → Prop
  #check Implies -- Prop → Prop → Prop

  variable (p q r : Prop)
  #check And p q                      -- Prop
  #check Or (And p q) r               -- Prop
  #check Implies (And p q) (And q p)  -- Prop


-- use this to build AXIOMS: introduce `Proof p` for each element `p : Prop`
-- `structure`, `axiom`: new commands
  -- these are the type of proofs of `p`. ie. AXIOMS

  structure Proof (p : Prop) : Type where
    proof : p
  #check Proof   -- Proof : Prop → Type

  axiom and_comm (p q : Prop) : Proof (Implies (And p q) (And q p))

  variable (p q : Prop)
  #check and_comm p q     -- Proof (Implies (And p q) (And q p))


-- RULES: in add to axoims, we also need rules to build new proofs from old ones
  -- ie modus ponens: proof of `Implies p q` and proof of `p`, we get proofs of `q`
    axiom modus_ponens : (p q : Prop) → Proof (Implies p q) →  Proof p → Proof q

    #check modus_ponens p q

  -- ie. natural deduction: spse, assuming `p` as hypothesis, we hv proof of `p`
    -- thus can cancel hypothesis to obtain proof of `Implies p q`
    axiom implies_intro : (p q : Prop) → (Proof p → Proof q) → Proof (Implies p q)


