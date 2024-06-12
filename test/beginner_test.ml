open Base (* needed for %test_eq *)
open Practice_problems.Beginner

let%test_unit "last" =
  [%test_eq: string option] (last [ "a"; "b"; "c" ]) (Some "c");
  [%test_eq: string option] (last []) None

let%test_unit "last two" =
  [%test_eq: (string * string) option]
    (last_two [ "a"; "b"; "c"; "d" ])
    (Some ("c", "d"));
  [%test_eq: (string * string) option] (last_two [ "a" ]) None

let%test_unit "nth element" =
  [%test_eq: string option] (nth 2 [ "a"; "b"; "c"; "d"; "e" ]) (Some "c");
  [%test_eq: string option] (nth 2 [ "a" ]) None

let%test_unit "length" =
  [%test_eq: int] (len [ "a"; "b"; "c"; "d" ]) 4;
  [%test_eq: int] (len []) 0

let%test_unit "reverse" =
  [%test_eq: string list] (revl [ "a"; "b"; "c" ]) [ "c"; "b"; "a" ]

let%test_unit "palandrome" =
  [%test_eq: bool] (pal [ "a"; "b"; "c" ]) false;
  [%test_eq: bool] (pal [ "x"; "a"; "m"; "a"; "x" ]) true
