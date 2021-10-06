-- foundational lexical structure of lean language
-- https://leanprover.github.io/lean4/doc/lexical_structure.html


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

def Foo.«bar.baz» := 0  -- name parts ["Foo", "bar.baz"]
   ident: `atomic_ident` | `ident` "." `atomic_ident`
   atomic_ident: `atomic_ident_start` `atomic_ident_rest`*
   atomic_ident_start: `letterlike` | "_" | `escaped_ident_part`
   letterlike: [a-zA-Z] | `greek` | `coptic` | `letterlike_symbols`
   greek: <[α-ωΑ-Ωἀ-῾] except for [λΠΣ]>
   coptic: [ϊ-ϻ]
   letterlike_symbols: [℀-⅏]
   escaped_ident_part: "«" [^«»\r\n\t]* "»"
   atomic_ident_rest: `atomic_ident_start` | [0-9'ⁿ] | `subscript`
   subscript: [₀-₉ₐ-ₜᵢ-ᵪ]
-/


/- LITERALS
represents fixed value


STRING
encoles by double quotes (") 
may contain line breaks (conserved in string value)

   string       : '"' `string_item` '"'
   string_item  : `string_char` | `string_escape`
   string_char  : [^\\]
   string_escape: "\" ("\" | '"' | "'" | "n" | "t" | "x" `hex_char` `hex_char`)
   hex_char     : [0-9a-fA-F]


CHAR
enclosed by single quotes (')

   char: "'" `string_item` "'"


NUMERIC
can be specified in various bases

   numeral    : `numeral10` | `numeral2` | `numeral8` | `numeral16`
   numeral10  : [0-9]+
   numeral2   : "0" [bB] [0-1]+
   numeral8   : "0" [oO] [0-7]+
   numeral16  : "0" [xX] `hex_char`+

DECIMAL
currently only used for some :keyword: set_option <options> values
   decimal    : [0-9]+ "." [0-9]+

-/


/- QUOTED SYMBOLS
in fixed set of commands (ie. below), symbols (known or unknown) can be quoted by enclosing them in backticks (``)
-- (:keyword: notation <notation_declarations>, 
-- :keyword: local notation <notation_declarations>, and 
-- :keyword: reserve <notation_declarations>)

-- quoted symbols are used by commands for registering new notations and symbols
-- may contain surrounding whitespace - for pretty printing and ignored while scanning
-- backticks not allowed in user-defined symbol, but they're used in some built in symbols (see :ref: quotations) that r accessible outside of set of commands above

   quoted_symbol      : "`" " "* `quoted_symbol_start` `quoted_symbol_rest`* " "* "`"
   quoted_symbol_start: [^0-9"\n\t `]
   quoted_symbol_rest : [^"\n\t `]
-/


/- DOC COMMENTS
special form of comments
used to document models and declaraitons

   doc_comment: "/--" ([^-] | "-" [^/])* "-/"
   mod_doc_comment: "/-!" ([^-] | "-" [^/])* "-/"
-/

/- FIELD NOTATION
trailing field notation tokens are used in expressions such as (1+1).to_string
-- note: a.to_string is a single :ref: indentifier <identifiers>>, but may be interpreted as field notation expression by the parser

   field_notation: "." ([0-9]+ | `atomic_ident`)
-/
