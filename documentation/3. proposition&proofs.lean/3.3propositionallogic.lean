/- lean defines all standard logical connectives and notation:
-- abstraction viewed as "introducing or "establishing" implication
-- application viewed as "elimination rule" - how to eliminate or use an implication in proof

Ascii	Unicode	Editor shortcut	Definition
True			True
False			False
Not	¬	\not, \neg	Not
/\	∧	\and	And
\/	∨	\or	Or
->	→	\to, \r, \imp	
<->	↔	\iff, \lr	Iff

-/

-- they all take values in `Prop`
variable (p q : Prop)

#check p → q → p ∧ q
#check ¬p → p ↔ False
#check p ∨ q → q ∨ p

-- order of operations:
  -- unary negation ¬ 
  -- ∧ 
  -- ∨ 
  -- → 

/- CONJUNCTION -/
