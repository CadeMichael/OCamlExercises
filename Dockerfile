# Use an official OCaml base image
FROM ocaml/opam:alpine

# Install dependencies and sudo
RUN sudo apk update && \
    sudo apk add bash git curl sudo neovim

# Create a sudoers file for the opam user
RUN echo "opam ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/opam && \
    sudo chmod 0440 /etc/sudoers.d/opam

# Switch to the 'opam' user provided by the image
USER opam

# Set the working directory
WORKDIR /home/opam/project

# Initialize OPAM and install OCaml packages
RUN opam init -y --disable-sandboxing && \
    opam switch create 4.14.0 && \
    eval $(opam env) && \
    opam install -y dune && \
    opam install -y ocaml-lsp-server && \
    opam install -y ocamlformat base && \
    opam install -y ppx_inline_test ppx_jane

ENV ENV="/home/opam/.bashrc"

RUN echo 'eval $(opam env)' >> /home/opam/.bashrc
