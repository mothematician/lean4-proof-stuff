/-NAMESPACES-/
-- ability to group defs into nested, HIERARCHICAL namespaces:
-- SORT OF LIKE CLASS OF FUNCTIONS AND DEFINITIONS IN PYTHON
  -- can import or use it as (classname).(funcname) too
-- can also be nested (see below)
-- can be closed and opened anytime and add more info to it, even in another file (see below)

namespace Foo
  def a : Nat := 5
  def f (x : Nat) : Nat := x + 7

  def fa : Nat := f a
  def ffa : Nat := f (f a)

  #check a
  #check f
  #check fa
  #check ffa
  #check Foo.fa
end Foo

-- #check a  -- error
-- #check f  -- error
#check Foo.a
#check Foo.f
#check Foo.fa
#check Foo.ffa

open Foo  -- can open multiple namespaces at once but recc to use refer by full name incase of conflicts

#check a
#check f
#check fa
#check Foo.fa


-- EXAMPLE: LEAN groups def and theoreoms involving lists into name space `List`
#check List.nil
#check List.cons
#check List.map

open List

#check nil
#check cons
#check map


-- nestedness
namespace Mam
  def a : Nat := 5
  def f (x : Nat) : Nat := x + 7

  def ma : Nat := f a

  namespace Bar
    def ffa : Nat := f (f a)

    #check fa
    #check ffa
  end Bar

  #check fa
  #check Bar.ffa
end Mam

#check Mam.ma
#check Mam.Bar.ffa

open Mam

#check ma
#check Bar.ffa


-- OPENING AGAIN
namespace Pap
  def a : Nat := 5
  def f (x : Nat) : Nat := x + 7

  def fa : Nat := f a
end Pap

#check Pap.a
#check Pap.f

namespace Pap
  def ffa : Nat := f (f a)
end Pap

#check Pap.ffa


-- namespace vs sections:
  -- namespace: organize data
  -- sections: declare variables for insertion in definitions, and delimiting scope of commands like `set_option` and `open`

  -- tho in some respects, they behave same:
    -- in particular, use the `variable` command within a namespace, its scope is limited to the namespace