# pokecat

## Description

pokecat contains two *main* scripts:

1. make_res.sh creates the ./res directory (which is contained in the git repo for convenience)
1. pokecat.sh prints random pokemon (up to Generation IV), contained in ./res, to the terminal using unicode block characters.

## TODO
\-

## Installation

1)  Install dependencies. For example, for ./src/pokecat.sh on macOS:

        brew install catimg

    , or on Ubuntu:

        apt install catimg

1)  Clone the repository:

        git clone https://github.com/gvlassis/pokecat.git

1)  cd to the cloned repository and run a script. For example, for ./src/pokecat.sh:

        cd pokecat
        ./src/pokecat.sh

1)  You can create a link inside a directory that is in your PATH. For example, *assuming  ~/.local/bin is in your PATH*:

        ln -sf "${PWD}/src/pokecat.sh" "${HOME}/.local/bin"

    Another good idea is to call ./src/pokecat.sh in your shell's initialization script (e.g. .bashrc, .zshrc). For example, for Bash:

        printf "${PWD}/src/pokecat.sh\n" >> "${HOME}/.bashrc"

## Architecture

There are 3 Bash scripts, namely utils.sh, make_res.sh and pokecat.sh.

utils.sh contains a function that checks for dependencies and is used by both make_res.sh and pokecat.sh for error handling. It has no dependencies.

make_res.sh downloads the pokemon sprites from <https://github.com/PokeAPI/sprites> and preprocesses them with calls to [PokeAPI](https://pokeapi.co/) and ImageMagick. It creates the directory ./res that contains 493 images, one for each pokemon, each named as ./res/ID-NAME.png. For it to work, we need svn, curl and mogrify in PATH.

> NOTE: For convenience, ./res has been included in the repository, so there is no need to run make_res.sh.

pokecat.sh prints a random pokemon from ./res to the terminal using catimg (the only dependency of pokecat.sh). You can trivially change catimg to any terminal image viewer of your choice.
