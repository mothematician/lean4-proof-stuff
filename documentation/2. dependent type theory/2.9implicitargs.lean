/- IMPLICIT ARGUMENTS -/

-- spse we hv implementation of lists as:
  universe u
  def Lst (α : Type u) : Type u := List α
  def Lst.cons (α : Type u) (a : α) (as : Lst α) : Lst α := List.cons a as
  def Lst.nil (α : Type u) : Lst α := List.nil
  def Lst.append (α : Type u) (as bs : Lst α) : Lst α := List.append as bs
  #check Lst          -- Type u_1 → Type u_1
  #check Lst.cons     -- (α : Type u_1) → α → Lst α → Lst α
  #check Lst.nil      -- (α : Type u_1) → Lst α
  #check Lst.append   -- (α : Type u_1) → Lst α → Lst α → Lst α

-- then we can construct lists of `Nat` as follows:
  #check Lst.cons Nat 0 (Lst.nil Nat)

  def as : Lst Nat := Lst.nil Nat
  def bs : Lst Nat := Lst.cons Nat 5 (Lst.nil Nat)

  #check Lst.append Nat as bs

-- bc the constructors r polymorphic over types, hv to repeatedly insert `Nat` 
-- this is very redundant - central part of dependent type theory is to infer info
  -- using underscore `_` to specify that that the system should fill info automatically 
  -- aka `IMPLICIT ARGUMENT`

    #check Lst.cons _ 0 (Lst.nil _)

    def as1 : Lst Nat := Lst.nil _
    def bs1 : Lst Nat := Lst.cons _ 5 (Lst.nil _)

    #check Lst.append _ as1 bs1
  

  -- `{}` can also tell lean that func should be inferred by default by using curly brackets in delcaration of variables
    universe w
    def Lst1 (α : Type w) : Type w := List α

    def Lst1.cons {α : Type w} (a : α) (as : Lst α) : Lst α := List.cons a as
    def Lst1.nil {α : Type w} : Lst α := List.nil
    def Lst1.append {α : Type w} (as bs : Lst α) : Lst α := List.append as bs

    #check Lst1.cons 0 Lst1.nil

    def as2 : Lst Nat := Lst1.nil
    def bs2 : Lst Nat := Lst1.cons 5 Lst1.nil

    #check Lst1.append as2 bs2


  -- `ident`: identify type is also implicit
    universe y
    def ident {α : Type y} (x : α) := x

    #check ident         -- ?m → ?m
    #check ident 1       -- Nat
    #check ident "hello" -- String
    #check @ident        -- {α : Type u_1} → α → α


  -- variables can also be implicit when decalred with `variable`
  universe z

  section
    variable {α : Type u}
    variable (x : α)
    def ident1 := x
  end

  #check ident1
  #check ident1 4
  #check ident1 "hello"
  
  
  -- automatically default to `nat` pink - within possibility to bo

  -- if want to change lobal arg to global arg, 
    #check @id        -- {α : Type u_1} → α → α
    #check @id Nat    -- Nat → Nat
    #check @id Bool   -- Bool → Bool

    #check @id Nat 1     -- Nat
    #check @id Bool true -- Bool

    

