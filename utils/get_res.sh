#!/usr/bin/env bash
# SPDX-FileCopyrightText: © 2023 Project's authors 
# SPDX-License-Identifier: MIT

utils_path="$(dirname ${0})"
res_path="${utils_path}/../res"
svn export https://github.com/PokeAPI/sprites/trunk/sprites/pokemon/versions/generation-iv/platinum "${res_path}"
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
    printf "${id}/493\n"
    name="$(curl "https://pokeapi.co/api/v2/pokemon/${id}" | yq ".name")"
    mv "${res_path}/${id}.png" "${res_path}/${id}-${name^}.png"
done 

# Hardcoded renames
mv "${res_path}/386-Deoxys-normal.png" "${res_path}/386-Deoxys.png"
mv "${res_path}/413-Wormadam-plant.png" "${res_path}/413-Wormadam.png"
mv "${res_path}/487-Giratina-altered.png" "${res_path}/487-Giratina.png"
mv "${res_path}/492-Shaymin-land.png" "${res_path}/492-Shaymin.png"

# Trim transparency
mogrify -trim ${res_path}/*

unset utils_path
unset res_path
unset name
