# Transform the cursor to box form on ssh command.
function preexec() {
	if [[ "$2" =~ '^ssh ' ]] {
		printf '\033[0 q'
	}
}

# Compile lesskey file if compile is needed.
if ([[ ! -f $LESSKEY ]] || [[ $LESSKEYRC -nt $LESSKEY ]]) {
	lesskey -o $LESSKEY $LESSKEYRC
}

# Create symbolic links for neovim and vim configs.
if ! [[ -L ~/.vim/vimrc ]] {
	ln -s ~/.vim/init.vim ~/.vim/vimrc
}
if ! [[ -L ~/.config/nvim ]] {
	ln -s ~/.vim ~/.config/nvim
}

# Create symbolic link for prompt theme if it's not already linked.
if ! [[ -L $ZDOTDIR/autoload/prompt_pure_setup ]] {
	ln -s $ZDOTDIR/plugins/pure/pure.zsh $ZDOTDIR/autoload/prompt_pure_setup
}
if ! [[ -L $ZDOTDIR/autoload/async ]] {
	ln -s $ZDOTDIR/plugins/pure/async.zsh $ZDOTDIR/autoload/async
}

# Recompile prompt files if it's needed.
zrecompile -p \
	-M $ZDOTDIR/autoload/async -- \
	-M $ZDOTDIR/autoload/prompt_pure_setup

# Register fasd to track most used files and directories.
function _fasd_preexec() {
	if (hash fasd &>/dev/null) {
		fasd --proc $(fasd --sanitize "$1") &>/dev/null
	}
}
add-zsh-hook preexec _fasd_preexec
