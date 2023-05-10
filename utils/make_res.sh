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
    check_dependencies svn curl jq mogrify
  
    local script_path="$(readlink -f "${0}")"
    readonly script_path
    local src_path="$(dirname "${script_path}")"
    readonly src_path
    local res_path="$(dirname "${src_path}")/res"
    readonly res_path
    # Use subversion to download only the directory containing the platinum sprites. Use export to exclude .svn and --force to replace ./res if it exists. 
    svn export --force https://github.com/PokeAPI/sprites/trunk/sprites/pokemon/versions/generation-iv/platinum "${res_path}"
    # Remove useless resources 
    rm -rf "${res_path}/back" "${res_path}/shiny" "${res_path}/female"

    # Keep only one Unown form
    rm "${res_path}"/201-*
    # Keep only one Castform form
    rm "${res_path}"/351-*
    # Keep only one Deoxys form
    rm "${res_path}"/386-*
    # Keep only one Burmy form
    rm "${res_path}"/412-*
    # Keep only one Wormadam form
    rm "${res_path}"/413-*
    # Keep only one Cherrim form
    rm "${res_path}"/421-*
    # Keep only one Shellos form
    rm "${res_path}"/422-*
    # Keep only one Gastrodon form
    rm "${res_path}"/423-*
    # Keep only one Rotom form
    rm "${res_path}"/479-*
    # Keep only one Giratina form
    rm "${res_path}"/487-*
    # Keep only one Shaymin form
    rm "${res_path}"/492-*
    # Keep only one Arceus form
    rm "${res_path}"/493-*

    for id in {1..493}; do
        printf "\e[35;1m${id}/493\e[0m\n"
        local name="$(curl "https://pokeapi.co/api/v2/pokemon/${id}" | jq -r ".name")"
        mv "${res_path}/${id}.png" "${res_path}/${id}-${name^}.png"
    done 

    # Hardcoded renames
    mv "${res_path}/386-Deoxys-normal.png" "${res_path}/386-Deoxys.png"
    mv "${res_path}/413-Wormadam-plant.png" "${res_path}/413-Wormadam.png"
    mv "${res_path}/487-Giratina-altered.png" "${res_path}/487-Giratina.png"
    mv "${res_path}/492-Shaymin-land.png" "${res_path}/492-Shaymin.png"

    # Trim transparency
    mogrify -trim "${res_path}/*"
}

main
