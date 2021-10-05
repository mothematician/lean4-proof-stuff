-- namespaces: most fundamental pieces of any Lean program are funcs organized into namespaces
-- are primary way to group things in Lean
namespace BasicFunctions


-- `def`: functions can be defined as below:
-- parentheses are optional, except when i use explicit type annotation - ie. (7-4)
-- variable type is inferred from function return type
def sampleFunction1 x := x*x + 3

-- functions: can also call functions within it
def result1 := sampleFunction1 2
-- functions: we can also specify the domain as below:
def sampleFunction2 (x : Nat) := 2^x - x + 3
def result2 := sampleFunction2 7


-- `if else`conditionals: more or less same as python
def sampleFunction3 (x : Int) :=
  if x > 100 then
    2*x*x - x + 3
  else
    2*x*x + x - 37


-- `#eval`: is used for evaluating whatever operation or proof i want
#eval 2+3

-- `printIn!`: used to include interpolated strings in result from '#eval'
-- `{}`: expressions inside {} are converted into strings using polymorphic method 'toString'
-- `{}`: can also call function directly within {}
#eval println! "The result of squaring the integer 2 and adding 3 is {result1}"
#eval println! "The result of applying the 2nd sample function to 7 is {result2}"
#eval println! "The result of applying sampleFunction3 to 2 is {sampleFunction3 2}"

end BasicFunctions