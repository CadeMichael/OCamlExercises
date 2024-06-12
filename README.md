# OCamlExercises

- all exercises can be found [here](https://ocaml.org/exercises)
- Slowly going to add unit tests for OCaml sample execises
- very informal more of an exercise in patience to get the project setup
    - I like dune but the docs were a bit tough to get through
        - ppx
        - installing required pacakges
        - structure with 'name' and 'public_name'
    - this is a starter for people to get comfortable with ocaml and start doing little problems

# Project Layout

- there are **test/** and **lib/** directories
- as you can imagine the unit tests go in test/ and the functions being tested go into lib/
- I have the dune files setup for 'beginner' and 'intermediate' modules (files named beginner.ml etc...) to get pulled from lib/ into test/
    - but if you would like to separate the tests based on some other differentiator you can simply change those. (test/dune and lib/dune)
- as you write functions you can write unit tests
- this isn't complete is more of a starting point

# Docker

- opam and ocaml are a bit hard to configure. So I figured a docker file would be the easiest way to get setup without installing 2G of pacakges on your host machine.
- the intended use of this is to edit the files within the docker container via the installed nvim included.
- however the docker-compose is setup to track the files in ./ (all files in the repo) so you could also start the container and send commands to it. 

## Connecting and using the nvim within the container

```sh
# docker compose builds Dockerfile
docker compose build

# start the containers
docker compose up -d

# enter the container, you can get the name with 'docker ps -a'
docker exec -ti <name> bash

# this drops you in the container and you can nvim into lib/ or test/ and start editing!

# I recommend the nvim commands ':!dune runtest' to run tests from nvim
# and ':!dune fmt' to format the entire project from withing nvim

# when done dont forget to shutoff
docker compose down
```

## Sending Commands

- one annoying thing about the unit test framework is that it only prints when something breaks so I'll present a `dune runtest` for a failing test here

```sh
# same as above, build and start the container...

# have bash execute a command, need '-l' as it simulates a login and will use bashrc
docker exec <name> bash -lc "dune runtest"
File "test/intermediate_test.ml", line 63, characters 0-279: encode 2 threw
(runtime-lib/runtime.ml.E "comparison failed"
  (((One b) (Many 3 a) (One b) (Many 2 c) (Many 2 a) (One d) (Many 4 e)) vs
    ((Many 4 a) (One b) (Many 2 c) (Many 2 a) (One d) (Many 4 e))
    (Loc test/intermediate_test.ml:64:13))).
  Raised at Ppx_assert_lib__Runtime.test_eq in file "runtime-lib/runtime.ml", line 95, characters 22-69
  Called from Practice_tests__Intermediate_test.(fun) in file "test/intermediate_test.ml", line 64, characters 13-28

FAILED 1 / 7 tests

# when done dont forget to shutoff
docker compose down
```
