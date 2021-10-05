-- foundational lexical structure of lean language


/- TOKENS
input is processed into stream of tokens by its scanner using UTF-8 encoding
-- can be separated by whitespace characters space, tab, line feed, carriage returns, comments
-- token: `symbol` | `command` | `ident` | `string` | `char` | `numeral` | `decimal` | `quoted_symbol` | `doc_comment` | `mod_doc_comment` | `field_notation`
-/

/- COMMENTS
-- single comments
/-for multi-line comments lol-/
-/


/- SYMBOLS
static tokens used in term notations and commands
can be both keyword-like (ie. the :keyword: have <structured_proofs>) or arbitrary Unicode characters
dynamically extend sets of symbols - via commands listed in :numref: quoted_symbols
-/

/- COMMAND TOKENS
static tokens that prefix any top-level declaration or action
usually keyword-like, w/ transitory commands like :keyword: #print <instructions> prefixed by extra #
set of built in commands is nested in :numref: Chapter %s <other_commands> section
dynamically extend sets of command tokens - via :keyword: [user_command] <attributes>
-/


/- IDENTIFIERS
atomic identifiers, aka. atomic name: 
alphanumeric string that doesn't begin w/ numberal A
parts can be escaped by enclosing them in pairs of french double quotes «»

a (hierarchical) identifier or name:
consists of one or more atomic names separated by periods
-/

def Foo.«bar.baz» := 0  -- name parts ["Foo", "bar.baz"]


