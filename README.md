# pokecat

## Description

pokecat is a utility that prints random pokemon (up to Generation IV) to the terminal using unicode block characters.

![](screenshot.png)

## Structure

There are 3 Bash scripts, namely `./utils.sh`, `./make_res.sh` and `./pokecat.sh`.

`./utils.sh` contains a function that checks for dependencies and is used by both `./make_res.sh` and `./pokecat.sh` for error handling. It has no dependencies.

`./make_res.sh` downloads the pokemon sprites from [](https://github.com/PokeAPI/sprites) and preprocesses them with calls to [PokeAPI](https://pokeapi.co/) and ImageMagick. It creates the directory `./res` that contains 493 images, one for each pokemon, each named as `./res/ID-NAME.png`. For it to work, we need `svn`, `curl`, `jq` and `mogrify` in `PATH`. **For convenience, `./res` has been included in the repository, so there is no need to run `./make_res.sh`**.

`./pokecat.sh` prints a random pokemon from `./res` to the terminal using `catimg` (the only dependency of `./pokecat.sh`). You can trivially change `catimg` to any terminal image viewer of your choice.

## Instructions

1)  Install dependencies. For example, for `./pokecat.sh` on macOS:

        brew install catimg

    , or on Ubuntu:

        apt install catimg

2)  Clone the repository:

        git clone https://github.com/gvlassis/pokecat.git

3)  cd to the cloned repository and run a script. For example, for `./pokecat.sh`:

        cd pokecat
        ./pokecat.sh

4)  You can create a link of your choice (e.g. `pkcat`) and add it to a directory that is in your `PATH`. For example, *assuming  `~/.local/bin` is in your `PATH`*:

        ln -sf "${PWD}/pokecat.sh" "${HOME}/.local/bin/pkcat"
        pkcat

    Another good idea might is to call `./pokecat.sh` in your shell's initialization script (e.g. `.bashrc`, `.zshrc`). For example, for Bash:

        printf "${PWD}/pokecat.sh\n" >> "${HOME}/.bashrc"
