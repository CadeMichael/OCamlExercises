open Base
open Stdio
open Practice_problems.Intermediate

let%expect_test "rev" =
  print_s [%sexp (List.rev [ 3; 2; 1 ] : int list)];
  [%expect {| (1 2 3) |}]

let%test_unit "flatten" =
  [%test_eq: string list]
    (flatten [ One "a"; Many [ One "b"; Many [ One "c"; One "d" ]; One "e" ] ])
    [ "a"; "b"; "c"; "d"; "e" ]

let%test_unit "compress" =
  [%test_eq: string list]
    (compress
       [ "a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e" ])
    [ "a"; "b"; "c"; "a"; "d"; "e" ]

let%test_unit "pack" =
  [%test_eq: string list list]
    (pack
       [
         "a";
         "a";
         "a";
         "a";
         "b";
         "c";
         "c";
         "a";
         "a";
         "d";
         "d";
         "e";
         "e";
         "e";
         "e";
       ])
    [
      [ "a"; "a"; "a"; "a" ];
      [ "b" ];
      [ "c"; "c" ];
      [ "a"; "a" ];
      [ "d"; "d" ];
      [ "e"; "e"; "e"; "e" ];
    ]

let%test_unit "encode" =
  [%test_eq: (int * string) list] (encode []) [];
  [%test_eq: (int * string) list] (encode [ "a" ]) [ (1, "a") ];
  [%test_eq: (int * string) list]
    (encode [ "a"; "a"; "b"; "b"; "b"; "c" ])
    [ (2, "a"); (3, "b"); (1, "c") ];
  [%test_eq: (int * string) list]
    (encode [ "a"; "b"; "a"; "b"; "a"; "b" ])
    [ (1, "a"); (1, "b"); (1, "a"); (1, "b"); (1, "a"); (1, "b") ];
  [%test_eq: (int * string) list]
    (encode
       [ "a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e" ])
    [ (4, "a"); (1, "b"); (2, "c"); (2, "a"); (1, "d"); (4, "e") ]

let%test_unit "encode 2" =
  [%test_eq: string rle list]
    (encode_cst
       [ "a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e" ])
    [
      Many (4, "a");
      One "b";
      Many (2, "c");
      Many (2, "a");
      One "d";
      Many (4, "e");
    ]

let%expect_test "printing encode" =
  print_s
    [%sexp
      (encode_cst
         [
           "a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e";
         ]
        : string rle list)];
  [%expect {|((Many 4 a) (One b) (Many 2 c) (Many 2 a) (One d) (Many 4 e))|}]
