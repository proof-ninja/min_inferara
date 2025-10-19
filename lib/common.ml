let (!%) f = Printf.sprintf f

let option_mplus x y =
  match x, y with
  | Some x, _ -> Some x
  | None, Some y -> Some y
  | None, None -> None
