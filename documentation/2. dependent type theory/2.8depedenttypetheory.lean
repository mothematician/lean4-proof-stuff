/-what makes dependent type theory dependent? (aka sigma type)-/

--types can depend on parameters
  -- ie. `list a` depends on arg `a`, this dependence distinguishes `List Nat` and `List Bool`
  -- `Vector a n` depends on 2 parameters: types of elements in vector `(a : type)` and length of vector `n : Nat`


-- dependent function/arrow type
  -- these functions/"arrows" depend on the type parameter of input too
  def cons (α : Type) (a : α) (as : List α) : List α :=
    List.cons a as

  #check cons Nat        -- Nat → List Nat → List Nat
  #check cons Bool       -- Bool → List Bool → List Bool
  #check cons            -- (α : Type) → α → List α → List α
    -- output above makes sense over (Type → α → list α → list α)
  
  #eval cons Nat 4 [4,5,6]  -- [4, 4, 5, 6] DAMN


-- can inspect the type of list functions like below
#check @List.cons    -- {α : Type u_1} → α → List α → List α
#check @List.nil     -- {α : Type u_1} → List α
#check @List.length  -- {α : Type u_1} → List α → Nat
#check @List.append  -- {α : Type u_1} → List α → List α → List α


-- dependent function types `(a : α) → β a` generalizes `α → β`
-- dependent cartesian product types `(a : α) × β a` generalizes `α × β`


-- aka `SIGMA types` & can also be written as: `Σ a : α, β a`
  -- can use `⟨a, b⟩` or `Sigma.mk a b` to create dependent pair

  universe u v

  def f (α : Type u) (β : α → Type v) (a : α) (b : β a) : (a : α) × β a :=
    ⟨a, b⟩  -- well damn. 
    /- basically, f is func that takes inputs: 
      - α of Type u
      - fun β that maps a to Type v
      - value a of type α (Type u)
      - value b of type β a (or Type v)
      and gives output/maps them all to cartesian product:
      - a of type α⊆u and b of type v-/

  def g (α : Type u) (β : α → Type v) (a : α) (b : β a) : Σ a : α, β a :=
    Sigma.mk a b

  def h1 (x : Nat) : Nat :=
    (f Type (fun α => α) Nat x).2 -- this .2 refers to fst or snd of the cartesian product

  #eval h1 34

  def h2 (x : Nat) : Nat :=
    (g Type (fun α => α) Nat x).2

  #eval h2 5 -- 5
