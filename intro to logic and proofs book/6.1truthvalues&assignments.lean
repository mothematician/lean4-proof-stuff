def A := true
def B := false
def C := true
def D := true
def E := false

def test (p : Prop) :=
  if p then "true" else "false"

#eval test ((A ∧ B) ∨ ¬ C)
#eval test (A → D)
#eval test (C → (D ∨ ¬E))
#eval test (¬(A ∧ B ∧ C ∧ D))