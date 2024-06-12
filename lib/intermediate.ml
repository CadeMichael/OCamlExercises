open Base

type 'a node = One of 'a | Many of 'a node list [@@deriving compare, sexp]
type 'a rle = One of 'a | Many of int * 'a [@@deriving compare, sexp]

let flatten (lis : 'a node list) : 'a list =
  (* flattens an returns in reverse order *)
  let rec aux (acc : 'a list) (cur : 'a node list) : 'a list =
    match cur with
    | [] -> acc
    | One x :: t -> aux (x :: acc) t
    | Many y :: t -> aux (aux acc y) t
  in
  List.rev (aux [] lis)

let rec compress = function
  | a :: (b :: _ as t) ->
      if String.equal a b then compress t else a :: compress t
  | smaller -> smaller (* less than 2 elements, matches: [] & [x] *)

let pack lis =
  let rec aux cur acc = function
    | [] -> []
    | [ x ] -> (x :: cur) :: acc
    | a :: (b :: _ as t) ->
        if String.equal a b then aux (a :: cur) acc t
        else aux [] ((a :: cur) :: acc) t
  in
  List.rev (aux [] [] lis)

let encode lis =
  let rec aux cnt = function
    | [] -> []
    | [ x ] -> [ (cnt, x) ]
    | a :: (b :: _ as t) ->
        if String.equal a b then aux (cnt + 1) t else (cnt, a) :: aux 1 t
  in
  aux 1 lis

let encode_cst (l : 'a list) : 'a rle list =
  let create_tuple (cnt : int) (elem : 'a) : 'a rle =
    if cnt = 1 then One elem else Many (cnt, elem)
  in
  let rec aux count acc = function
    | [] -> []
    | [ x ] -> create_tuple (count + 1) x :: acc
    | hd :: (snd :: _ as tl) ->
        if String.equal hd snd then aux (count + 1) acc tl
        else aux 0 (create_tuple (count + 1) hd :: acc) tl
  in
  List.rev (aux 0 [] l)