-- DEFINITIONS

-- recall that `def` keyword provide one important way of declaring new named objects

/- ALL of these are equivalent
  and can think of `def` as a kind of named `lambda`
  double4) can omit TYPE DECLARATIONS if lean has enough info to infer it -/
def double1 (x : Nat) : Nat := x + x
def double2 (x : Nat) : Nat := 2 * x
def double3 : Nat → Nat := fun x => x + x
def double4 := fun (x : Nat) => x + x

#eval double1 5 
#eval double2 4
#eval double3 34

/- GENERAL FORM of def is:
- def foo : α := bar
- where a is the type returned from expression bar
- lean can usually infer a but good to be explicit
- bar can be any expression, not just a lambda. 
- ie. it can be used like this: -/
def pi := 3.141592654


-- `def` can also do the following (JUST LIKE PYTHON):
-- multiple inputs
  def add1 (x y : Nat) := x + y
  def add2 (x : Nat) (y : Nat) := x + y
-- include interesting expressions like conditionals
  def greater (x y : Nat) := if x > y then x else y
-- def func that takes another func as input
  def doubletwice (f : Nat → Nat) (x : Nat) : Nat := f (f x)
-- more abstract: specify args that are like type parameters
  -- ie. (α β γ : Type)
  def compose (α β γ : Type) (g : β → γ) (f : α → β) (x : α) : γ := g (f x)
  -- this would work over any type α β γ - doesn't have to just be Nat or Bool, etc
  -- thus can compose just about ANY 2 functions, as long as they each take one parameter and type of output matches input
  def square (x : Nat) : Nat :=
    x * x
def double4times (x : Nat) := double4 (double4 x)

#eval add1 4 5
#eval add2 498 534
#eval greater 90 80
#eval doubletwice double4 5
#eval compose Nat Nat Nat double4times square 3 -- YOOO THIS IS COOL


-- LOCAL DEFINITIONS

-- introduce local definitions using `let` keyword

