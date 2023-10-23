script_path="$(readlink -f "${0}")"
src_path="$(dirname "${script_path}")"
root_path="$(dirname "${src_path}")"
. "${src_path}/utils.sh"
check_dependencies catimg

# Check that ./res is indeed a directory
if [ ! -d "${root_path}/res" ]; then
    printf "\e[31m${script_path}: ${root_path}/res is not a directory. Run ${src_path}/make_res.sh.\e[0m\n" >& 2
    exit 2
fi

# Get a random pokemon
pokemon="$(ls "${root_path}/res" | sort -R | head -n 1 | xargs basename -s ".png")"

# Show the pokemon. Replace catimg with the terminal image viewer of your choice
catimg "${root_path}/res/${pokemon}.png"
printf "\e[1m${pokemon}\e[0m\n"