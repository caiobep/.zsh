foreach piece (
	aliases.zsh
	exports.zsh
	functions.zsh
	plugins.zsh
) { source ~/.zsh/config/$piece }


###-tns-completion-start-###
if [ -f /Users/caiobep/.tnsrc ]; then 
    source /Users/caiobep/.tnsrc 
fi
###-tns-completion-end-###
