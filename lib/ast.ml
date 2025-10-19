type op =
  | Plus | Minus | Mult | Div
  | Equals | Lte | Lt | Gte | Gt
[@@deriving show]

type expr =
  | At
  | Id of string
  | Apply of expr * expr list
  | Op of op * expr * expr
[@@deriving show]

type statement =
  | Let of string * expr
  | Assert of expr
  | Expr of expr
[@@deriving show]

type decl =
  | FunDecl of string * string list * statement list
  | External of string * string list * string
[@@deriving show]

type program = decl list
[@@deriving show]
