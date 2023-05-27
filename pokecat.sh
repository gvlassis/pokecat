#!/usr/bin/env bash
# SPDX-FileCopyrightText: © 2023 Project's authors 
# SPDX-License-Identifier: MIT

script_path="$(readlink -f "${0}")"
root_path="$(dirname "${script_path}")"
source "${root_path}/utils.sh"
check_dependencies catimg

# Check that ./res is indeed a directory
if [ ! -d "${root_path}/res" ]; then
    printf "\e[91;1m${script_path} (Error): ${root_path}/res is not a directory. Run ${root_path}/make_res.sh.\e[0m\n" >& 2
    exit 2
fi

# Get a random pokemon
pokemon="$(ls "${root_path}/res" | shuf -n 1 | xargs basename -s ".png")"

# Show the pokemon. Replace catimg with the terminal image viewer of your choice.
catimg "${root_path}/res/${pokemon}.png"
printf "\e[1m${pokemon}\e[0m\n"