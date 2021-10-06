-- Lean has first-class functions.
-- they're funcs that are teated like any other variables
  -- can be passsed as args to other funcs, return by another, assigned as value to variable

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
-- if the theorem is not consistent, it will show an error
-- `rfl` is reflexivity - Lean "symbolically" reduces both sides of equality till they're equal
theorem twiceAdd2 (a : Nat) : twice (fun x => x + 3) a = a + 6 := rfl


-- induction: `FILL LATER`
-- enumerated types: special case of inductive types
  -- this creates new type `Weekday`
  -- there's 7 constructors in `Weekday` namespace - monday, tuesday, etc are distinct elements
  -- no other distinguishing properties
inductive Weekday where 
  | sunday    : Weekday
  | monday    : Weekday
  | tuesday   : Weekday
  | wednesday : Weekday
  | thursday  : Weekday
  | friday    : Weekday
  | saturday  : Weekday

-- `#check`: prints type of term
#check Weekday.sunday
#check Weekday.monday

-- `open`: opens namespace, making all declarations in it accessible wiithout qualification
open Weekday
#check sunday
#check tuesday


-- `match _ with`: even crazier functions: define by pattern matching
def natOfWeekday (d : Weekday) : Nat :=
  match d with
  | sunday    => 1
  | monday    => 2
  | tuesday   => 3
  | wednesday => 4
  | thursday  => 5
  | friday    => 6
  | saturday  => 7

#eval natOfWeekday monday


-- boolean functions: True and False
  -- `fun` + `match`  is a common idiom.
  -- The following expression is syntax sugar for `fun d => match d with | monday => true | _ => false`
def isMonday : Weekday → Bool :=
  fun
    | monday => true
    | _      => false

#eval isMonday monday
#eval isMonday sunday


-- type classes:
-- polymorphic methods:

-- `toString` (method): converts values to string
#eval toString 10
#eval toString (10, 20)

-- `toString` (method) conevrts values of any type that implements `ToString` (class)
-- `instance ... where`: instance: specific realization of any object
instance : ToString Weekday where
  toString (d : Weekday) : String :=
    match d with
    | sunday    => "Sunday"
    | monday    => "Monday"
    | tuesday   => "Tuesday"
    | wednesday => "Wednesday"
    | thursday  => "Thursday"
    | friday    => "Friday"
    | saturday  => "Saturday"

#eval toString (sunday, 10)

-- more matching example
def Weekday.next (d : Weekday) : Weekday :=
  match d with
  | sunday    => monday
  | monday    => tuesday
  | tuesday   => wednesday
  | wednesday => thursday
  | thursday  => friday
  | friday    => saturday
  | saturday  => sunday

#eval Weekday.next Weekday.wednesday
-- or use `open`
#eval next wednesday

-- alternatively, use sugar syntax - no need for `instance`, `match`
def Weekday.previous : Weekday -> Weekday
  | sunday    => saturday
  | monday    => sunday
  | tuesday   => monday
  | wednesday => tuesday
  | thursday  => wednesday
  | friday    => thursday
  | saturday  => friday

#eval next (previous wednesday)


-- associated theorem + more complex matching: prove that for any `Weekday` `d`, `next (previous d) = d`
theorem Weekday.nextOfPrevious (d : Weekday) : next (previous d) = d :=
  match d with
  | sunday    => rfl
  | monday    => rfl
  | tuesday   => rfl
  | wednesday => rfl
  | thursday  => rfl
  | friday    => rfl
  | saturday  => rfl


-- metaprogramming (or "tactics") for theorems, rather than writing everything out
-- `cases`: proof by case distinction
theorem Weekday.nextOfPrevious' (d : Weekday) : next (previous d) = d := by
  cases d       -- A proof by case distinction
  all_goals rfl  -- Each case is solved using `rfl`
