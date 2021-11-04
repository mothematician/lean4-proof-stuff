variable {p : Prop}
variable {q : Prop}

section hrm
-- theorems involving only `→` can be proved w lambda
-- `theorem` command intrduces new theorem - basically a version of `def` command (kernel sees it the same)
  theorem t1 : p → q → p := fun hp : p => fun hq : q => hp
  #print t1

  -- this is like definition of constant function, but using args of `Prop` rather than `Type`
  -- intuitively, it assumes `p` and `q` are true, & uses first hypothesis (trivially) to establish conclusion `p` is true

-- `theorem` - basically a version of `def` command (kernel sees it the same)
-- but there's a few pragmatic diffs:
  -- in normal circumstances - not necessary to unfold def of a theorem
  -- lean tags proofs as irreducible - hint to not unfold
  -- lean also able to process & check proofs in parallel (since assissing correctness of proof does not require knowing details of another)

/- I THINK THIS IS THE IMPORTANT PART -/

-- lambda abstractions `hp : p` and `hq : q` can be viewed as temporary assumptions in proof of `t2`
  -- lean allows us to specify type of final term `hp` with `show` statement
    -- adding this extra info can improve clarity of a proof and help detect errors.
    -- `show` does nothing more than annotate the type
    -- internally, all presentations of `t2` produce same term

  theorem t2 : p → q → p :=
    fun hp : p =>
    fun hq : q =>
    show p from hp
  #print t2

-- can move lambda abs variables to left of the colon:  
  theorem t3 (hp : p) (hq : q) : p := hp
  #print t3    -- p → q → p

  -- then apply theorem t4 as func application
  axiom hp : p 
  theorem t4 : q → p := t1 hp
  -- here `axiom` declaration postulates existence of element of given type (& may compromise logical consistency)
    -- ie can use to postulate empty type `False` has an element

      axiom unsound : False
      -- Everything follows from false
      theorem ex : 1 = 0 :=
      False.elim unsound
  -- thus declaring an axiom `hp : p` is tantamount to declaring that `p` is true as witnessed by `hp`
  -- applying theorem `t4 : p → q → p` to fact that `hp : p` that `p` is ture yields `t1 hp : q → p`

  -- type of t1,2,3,4 is now `∀ {p q : Prop}, p → q → p` 
    -- can read this as, "for every pair of props `p q`, we hv `p → q → p`"
    -- ie can move all parameters to right of colon
      theorem t5 : ∀ {p q : Prop}, p → q → p :=
        fun {p q : Prop} (hp : p) (hq : q) => hp
    
    -- (if p and q has been delcared as variables, lean can generalize)
      variable {p q : Prop}
      theorem t6 : p → q → p := fun (hp : p) (hq : q) => hp

    -- THEN by props-as-types correspondence, we can declare the assumption `hp` that `p` holds, as another variable
      -- lean detects it uses `hp` and automatically adds `hp : p` as premise
      variable {p q : Prop}
      variable (hp : p)
      theorem t7 : q → p := fun (hq : q) => hp
      #print t7
end hrm


/- generalizing t -/
-- applies to all variables
section bruv
theorem t0 (p q : Prop) (hp : p) (hq : q) : p := hp

variable (p q r s : Prop)

#check t0 p q                -- p → q → p
#check t0 r s                -- r → s → r
#check t0 (r → s) (s → r)    -- (r → s) → (s → r) → r → s

variable (h : r → s)
-- variable `h` of type `r → s` can be views as hypothesis or premise that `r → s` holds
#check t0 (r → s) (s → r) h  -- (s → r) → r → s


/- this is composition func from chapter 2 but using props instead of types-/
variable (p q r s : Prop)

theorem t01 (h₁ : q → r) (h₂ : p → q) : p → r :=
fun h₃ : p =>
show r from h₁ (h₂ h₃)
-- t01 says fun of h₁ and h₂ defined above composes idk

end bruv