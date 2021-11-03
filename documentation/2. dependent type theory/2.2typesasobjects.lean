/- TYPES AS OBJECTS -/

-- types themselves are objects
#check Nat               -- Type
#check Bool              -- Type
#check Nat → Bool        -- Type
#check Nat × Bool        -- Type
#check Nat → Nat         -- ...
#check Nat × Nat → Nat
#check Nat → Nat → Nat
#check Nat → (Nat → Nat)
#check Nat → Nat → Bool
#check (Nat → Nat) → Nat

-- can also declare new constants for types
def α : Type := Nat
def β : Type := Bool
def F : Type → Type := List
def G : Type → Type → Type := Prod

#check α        -- Type
#check F α      -- Type
#check F Nat    -- Type
#check G α      -- Type → Type
#check G α β    -- Type
#check G α Nat  -- Type

#check Prod α β       -- Type
#check α × β          -- Type
#check Prod Nat Nat   -- Type
#check Nat × Nat      -- Type

-- `List α` denotes type of lists of elements of type α
#check List α    -- Type
#check List Nat  -- Type


-- meta moment: HIERARCHY of types:
-- lean's underlying foundation has infinite hierarchy of types
#check Type     -- technically shortcut for Type 0; Type 1
#check Type 1   -- Type 2
#check Type 2   -- Type 3
#check Type 3   -- Type 4
#check Type 4   -- Type 5
/-
think of Type 0 as universe of "small"/"ordinary" types
then Type 1 ia larger universes of types, that contain Type 0 as element
Type 2 even larger unvierse of types, containing Type 1
so on...
-/


-- POLYMORPHISM

-- some operations need to be polymorphic over type universes
  -- ie. `List α` should make sense for any type α no matter which type universe it lives in
-- thus type annotation of function `List`:
  -- `u_1` is variable ranging over type levels
  -- output of `#check`: whenever α is Type n, List α also is Type n
-- same case for `Prod`
#check List    -- Type u_1 → Type u_1
#check Prod    -- Type u_1 → Type u_2 → Type (max u_1 u_2)

-- to define polymorphic constants, Lean allows you to declare universe vaiables explicitly
  -- w/ `universe` command:
universe u
def A (α : Type u) : Type u := Prod α α
#check A    -- Type u → Type u

-- can also avoid universe command by providing universe parameters when defining A
def D.{d} (α : Type d) : Type d := Prod α α
#check D    -- Type u → Type u