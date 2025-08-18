export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh" 
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
ZSH_THEME="agnoster"

plugins=(git
    zsh-syntax-highlighting
    zsh-autosuggestions
    git-open
    extract
    )
source $ZSH/oh-my-zsh.sh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# zoxide init
eval "$(zoxide init zsh)"

alias bat='batcat'
alias vi='nvim'
export EDITOR='nvim'
bindkey '^Y' autosuggest-accept

# import ctrl-t(for file)/ctrl-r(for history command)/alt-c(for change directory)
source <(fzf --zsh)
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always {}'"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lijie/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lijie/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lijie/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lijie/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# yazi ,using y instead of default yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
# -- claude-code.top/dashboard
# export ANTHROPIC_BASE_URL=https://api.claude-code.top/api/claudecode
# export ANTHROPIC_API_KEY='sk-ant-api03-YVnioktwChu0migGeavLxcz7XrzBLJUC4RpUUpc7Xsf2SvLVzRv0AaLr--RGWXJner4Uzx3jH92NxILxRk8DAg'
# export ANTHROPIC_AUTH_TOKEN='sk-ant-api03-YVnioktwChu0migGeavLxcz7XrzBLJUC4RpUUpc7Xsf2SvLVzRv0AaLr--RGWXJner4Uzx3jH92NxILxRk8DAg'
# -code.wenwen-ai
export ANTHROPIC_BASE_URL=https://code.wenwen-ai.com
export ANTHROPIC_AUTH_TOKEN='sk-SdrRypsRCRYsiF9LLnFT4DQrLrLNfqutpWSlezAi3fCjirfG'
