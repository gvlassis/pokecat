#!/usr/bin/env bash
# SPDX-FileCopyrightText: © 2023 Project's authors 
# SPDX-License-Identifier: MIT

function main(){

    function check_dependencies(){
        local dependencies=$@
        readonly dependencies 

        local missing_dependencies=""
        for dependency in $dependencies; do
            if ! command -v "${dependency}" &>/dev/null; then
                if [ -n "${missing_dependencies}" ]; then
                    missing_dependencies="${missing_dependencies}, ${dependency}"
                else
                    missing_dependencies="${dependency}"
                fi
            fi
        done

        if [ -n "${missing_dependencies}" ]; then
            local script_path="$(readlink -f "${0}")"
            readonly script_path
            printf "\e[31;1m${script_path} (Error): The following dependencies are not in PATH: ${missing_dependencies}.\e[0m\n" >&2
            exit 1
        fi
    }
    check_dependencies catimg

    local script_path="$(readlink -f "${0}")"
    readonly script_path
    local src_path="$(dirname "${script_path}")"
    readonly src_path
    local res_path="$(dirname "${src_path}")/res"
    readonly res_path
    # Check that ./res is indeed a directory
    if [ ! -d "${res_path}" ]; then
        printf "\e[31;1m${script_path} (Error): ${res_path} is not a directory. Run ./utils/make_res.sh.\e[0m\n" >&2
        exit 2
    fi

    # Get a random pokemon
    local pokemon="$(ls "${res_path}" | shuf -n 1 | xargs basename -s ".png")"
    readonly pokemon

    # Show the pokemon. Replace catimg with the terminal image viewer of your choice. 
    catimg "${res_path}/${pokemon}.png"
    printf "\e[1m󰐝 ${pokemon}\e[0m\n"
}

main