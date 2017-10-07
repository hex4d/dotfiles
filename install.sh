# deploy dot files

DOTFILES_DIR="dotfiles"
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
dotfiles_dir=$script_dir'/'$DOTFILES_DIR
target_dir=$HOME'/'

if [ $(uname) = "Darwin" ]; then
	# for file in $( ls -a $dotfiles_dir); do
	# 	if [ $file = "." ] || [ $file = ".." ]; then
	# 		continue;
	# 	fi
	# 	if [ -a $HOME/$file ]; then
	# 		echo "exists"
	# 	else
	# 		echo "ln"
	# 	fi
	# done
	for file in $( find $DOTFILES_DIR -type f ) ; do
		filepath=${file#$DOTFILES_DIR/}
		ppath=$(dirname $HOME/$filepath)
		echo $ppath
		mkdir -p $ppath
	 	ln -s $(pwd $(dirname $file))/$file $HOME/$filepath
	done 
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	cp -rs $dotfiles_dir $target_dir 
fi

