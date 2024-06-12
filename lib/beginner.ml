(* beginner.ml *)

let rec last lis =
  match lis with [] -> None | [ x ] -> Some x | _ :: xs -> last xs

let rec last_two lis =
  match lis with
  | [] | [ _ ] -> None
  | [ x; y ] -> Some (x, y)
  | _ :: t -> last_two t (* note lack of [] around _ :: t *)

let rec nth i = function
  | [] -> None
  | h :: t -> if i = 0 then Some h else nth (i - 1) t (* still imutable *)

(* using match on a lis *)
(* let rec len lis = match lis with *)
(* | [] -> 0 *)
(* | _ :: t -> 1 + (len t) *)

(* defining with 'function' *)
let len lis =
  let rec aux n = function [] -> n | _ :: t -> aux (n + 1) t in
  aux 0 lis

let revl lis =
  let rec aux acc = function [] -> acc | h :: t -> aux (h :: acc) t in
  aux [] lis

let pal lis = lis = revl lis
