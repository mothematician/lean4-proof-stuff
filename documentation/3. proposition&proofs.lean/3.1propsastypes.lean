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


/-
this approach provides reasonable way to build asssertations adn prooff
--determining that an epxression `t` is correct proof of assertation `p` is simply checking that t has type `Proof p`

more possible simplifications: avoiding repeatedly writing `Proof`:
-- conflating `Proof p` w `p` itself
  -- whenever we hv `p : Proof` we can interpret `p` as type - type of its proofs
  -- can read `t ; p` as assertion that `t` is proof of `p`

KINDA OBV:
once we make this identification, rules for implication show we can pass back & forth between `Implies p q` and `p → q`
-- corresponds to having func that takes any element of `p` to element of `q`
  -- thus `implies` is redundant, can just use `→` for implication 


this approach followed in CALCULUS OF VARIATIONS and in Lean
-- Curry-Howard isomorphism aka proposition-as-types paradigm
-- in fact `Prop` is syntactic sugar for `Sort 0` - very bottom of type hierarchy
-- `Type u` is just syntatic sugar for `Sort (u+1)`
-- `Prop` has some special features but is closed under arrow constructor like other uiverses
  -- if we have `p q : Prop` then `p → q : Prop`
-/


/- 
Two ways to think about props-as-types paradigm:
1| constructive view of logic and maths, faithful rendering of what it means to be a prop
  -- prop `p` represents a sort of data type (specification of type of data that constitutes a proof)
2| simple coding trick:
  -- to each prop `p` we associate type that is empty if `p` is false, has single element `*` if `p` is true - inhabited
  just so happens that rules of func app & abs can conviniently help us keep trck of which elements of `Prop` are inhabited
  thus constructing element `t : p` tells us that `p` is indeed true
  -- proof of `p → q` uses "the fact that `p` is true" to obtain "the fact that `q` is true"

    PROOF IRELLEVANCE
    -- if `p : Prop` is any prop, Lean's kernel treats any two elements `t1 t2 : p` as DEFINITIONALLY EQUAL
    -- same way as it treats `(fun x => t) s` and `t[s/x]` as DEFINITIONALLY EQUAL
    -- consistent with interpretation above - even tho we can treat proofs `t : p` as ordinary objects in dtt, they carry no info beyond `p` is true


differ in fundamental way: 
-- constructive pov: proofs are abs mathematical objects that are DENOTED by suitable expressions in dtt
-- coding trick: expressions do not denote anything interesting - expressions themselves ARE proofs
-/

/-
may slip between the two ways of thinking: 
-- at times saying that an expression "constructs" or "produces" or "returns" a proof of a proposition, and at other times simply saying that it "is" such a proof

all that matters is btotom line: 
-- to formally express assertion in dtt, we need to exhibit a term `p : Prop` 
-- to prove assertion, we need `t : p`
-- lean's task is to help us construct such a term, `t` and to verify is well-formed and correct type
-/