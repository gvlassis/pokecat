#!/usr/bin/env bash
# SPDX-FileCopyrightText: © 2023 Project's authors 
# SPDX-License-Identifier: MIT

src_path="$(dirname ${0})"
res_path="${src_path}/../res"

pokemon="$(ls ${res_path} | shuf -n 1 | xargs basename -s ".png")"

viu -t "${res_path}/${pokemon}.png"
printf "\e[1m󰐝 ${pokemon}\e[0m\n"

unset src_path
unset res_path
unset pokemon