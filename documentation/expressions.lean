-- https://leanprover.github.io/lean4/doc/expressions.html

/- UNIVERSES
by def, every type in lean is an expression of type 'Sort u' for some universe level u

universe level is one of the following:
-- natural number n
-- universe variable u (declared w/ command 'universe' or 'universes')
-- expression u + n, where u is universe level and n is natural number
-- expression max u v, where u, v are universes
-- expression imax u v, where u, v are universe levels

universe u v

#check Sort u
#check Sort 5
#check Sort (u + 1)
#check Sort (u + 3)
#check Sort (max u v)
#check Sort (max (u + 3) v)
#check Sort (imax (u + 3) v)
#check Prop
#check Type
-/


theorem and_commutative (p q : Prop) : p ∧ q → q ∧ p :=
  fun hpq : p ∧ q =>
  have hp : p := And.left hpq
  have hq : q := And.right hpq
  show q ∧ p from And.intro hq hp

