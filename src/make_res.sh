script_path="$(readlink -f "${0}")"
src_path="$(dirname "${script_path}")"
root_path="$(dirname "${src_path}")"
. "${src_path}/utils.sh"
check_dependencies svn curl mogrify

# Use subversion to download only the directory containing the platinum sprites. Use export to exclude .svn.
printf "Downloading directory with sprites\n"
svn export --force -q https://github.com/PokeAPI/sprites/trunk/sprites/pokemon/versions/generation-iv/platinum "${root_path}/res"

# Remove useless resources
rm -rf "${root_path}/res/back" "${root_path}/res/shiny" "${root_path}/res/female"

# Keep only one Unown form
rm "${root_path}/res/201-"*
# Keep only one Castform form
rm "${root_path}/res/351-"*
# Keep only one Deoxys form
rm "${root_path}/res/386-"*
# Keep only one Burmy form
rm "${root_path}/res/412-"*
# Keep only one Wormadam form
rm "${root_path}/res/413-"*
# Keep only one Cherrim form
rm "${root_path}/res/421-"*
# Keep only one Shellos form
rm "${root_path}/res/422-"*
# Keep only one Gastrodon form
rm "${root_path}/res/423-"*
# Keep only one Rotom form
rm "${root_path}/res/479-"*
# Keep only one Giratina form
rm "${root_path}/res/487-"*
# Keep only one Shaymin form
rm "${root_path}/res/492-"*
# Keep only one Arceus form
rm "${root_path}/res/493-"*

printf "Calling PokeAPI to get names\n"
for id in {1..493}; do
    printf "${id}/493\n"
    name=$(curl -LsS "https://pokeapi.co/api/v2/pokemon/${id}" | python3 -c "import json,sys; obj=json.load(sys.stdin); print(obj['name'])")
    mv "${root_path}/res/${id}.png" "${root_path}/res/${id}-${name^}.png"
done

# Hardcoded renames
mv "${root_path}/res/386-Deoxys-normal.png" "${root_path}/res/386-Deoxys.png"
mv "${root_path}/res/413-Wormadam-plant.png" "${root_path}/res/413-Wormadam.png"
mv "${root_path}/res/487-Giratina-altered.png" "${root_path}/res/487-Giratina.png"
mv "${root_path}/res/492-Shaymin-land.png" "${root_path}/res/492-Shaymin.png"

# Trim transparency
mogrify -trim "${root_path}/res/*"