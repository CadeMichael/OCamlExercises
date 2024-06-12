#!/bin/bash

# Get the list of container names
container_names=$(docker ps --format "{{.Names}}")

# Initialize an empty variable to hold the matching name
matching_name=""

# Loop through each container name
for name in $container_names; do
  # check if the name contains "ocaml"
  if [[ $name == *ocaml* ]]; then
    matching_name="$name"
    break  # Exit the loop after finding the first match
  fi
done

# Check if a matching name was found
if [ -n "$matching_name" ]; then
  docker exec -ti "$matching_name" bash
else
  echo "Container Not running"
fi
