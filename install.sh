script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
dotfiles_dir=$script_dir'/dotfiles/.'
target_dir=$HOME'/'
cp -rs $dotfiles_dir $target_dir 
