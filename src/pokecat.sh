#!/usr/bin/env bash
# SPDX-FileCopyrightText: © 2023 Project's authors 
# SPDX-License-Identifier: MIT

dependencies="catimg"
missing_dependencies=""
for dependency in ${dependencies}; do
    if ! command -v "${dependency}" &>/dev/null; then
        if [ -n "${missing_dependencies}" ]; then
            missing_dependencies="${missing_dependencies}, ${dependency}"
        else
            missing_dependencies="${dependency}"
        fi
    fi
done

if [ -n "${missing_dependencies}" ]; then
    printf "\e[31;1mError: The following dependencies are not in PATH: ${missing_dependencies}\e[0m"
    exit 1
fi

src_path="$(readlink -f "$(dirname "${0}")")"
res_path="$(readlink -f "$(dirname "${src_path}")")/res"
if [ ! -d "${res_path}" ]; then
    printf "\e[31;1mError: ${res_path} is not a directory. Run utils/get_res.sh.\e[0m\n"
    exit 2
fi

pokemon="$(ls "${res_path}" | shuf -n 1 | xargs basename -s ".png")"

catimg "${res_path}/${pokemon}.png"
printf "\e[1m󰐝 ${pokemon}\e[0m\n"

unset dependencies
unset missing_dependencies
unset dependency
unset src_path
unset res_path
unset pokemon