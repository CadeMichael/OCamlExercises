(lang dune 3.15)

(name practice-problems)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Cade")

(maintainers "More of a starter for people to use")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name practice-problems)
 (synopsis "Template to get started doing practice problems and unit testing them")
 (description "problems go into lib/[difficulty].ml and are imported by test/[difficulty]_test.ml")
 (depends ocaml dune)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
