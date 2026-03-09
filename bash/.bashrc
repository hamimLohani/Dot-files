# Bash configuration

# Starship prompt
eval "$(starship init bash)"

# Enable bash-completion if available
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# History-based autosuggestions
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups

# Arrow key history search
bind '"\e[A": history-search-backward'  # Up arrow
bind '"\e[B": history-search-forward'   # Down arrow

# Right arrow moves forward (default behavior)
bind '"\e[C": forward-char'

# Left arrow accepts suggestion (requires bash-autosuggestions or hstr)
# For basic readline, left arrow moves backward
bind '"\e[D": backward-char'

# cddir function - search and cd into directories
cddir() {
    local base_dir="${1:-$HOME}"
    base_dir="${base_dir/#\~/$HOME}"

    if [[ ! -d "$base_dir" ]]; then
        echo "❌ '$base_dir' is not a valid directory"
        return 1
    fi

    local dir
    dir=$(find "$base_dir" -type d 2>/dev/null | fzf --prompt="📁 Pick a folder: ")

    if [[ -n "$dir" ]]; then
        cd "$dir" || echo "❌ Failed to cd into $dir"
    else
        echo "⚠️ Cancelled"
    fi
}

# Aliases
alias openWithNvim='nvim $(fzf -m --preview="bat --color=always {}")'
alias ls='eza'
alias cat='bat'

# Editor
export EDITOR='nvim'

# Java configuration
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# runjava function
runjava() {
    if [ -z "$1" ]; then
        echo "Usage: runjava <folder>"
        return 1
    fi

    folder="$1"
    file=$(find "$folder" -name "*.java" | fzf)

    if [ -z "$file" ]; then
        echo "No file selected."
        return 1
    fi

    class=$(basename "$file" .java)
    javac "$folder"/*.java && java -cp "$folder" "$class"
}

# Path exports
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export JAVA_HOME=/opt/homebrew/Cellar/openjdk/25

# Terminal colors
export TERM=xterm-256color
export COLORTERM=truecolor
export PATH="/opt/homebrew/bin:$PATH"

# CPLEX configuration
export CPLEX_HOME=/Users/Inz_mac/Applications/CPLEX_Studio_Community2212/cplex
export DYLD_LIBRARY_PATH=$CPLEX_HOME/lib/arm64_osx/static_pic:$DYLD_LIBRARY_PATH
export PATH=$CPLEX_HOME/bin:$PATH

# Antigravity
export PATH="/Users/Inz_mac/.antigravity/antigravity/bin:$PATH"

# Conda initialize
__conda_setup="$('/Users/Inz_mac/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/Inz_mac/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/Inz_mac/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/Inz_mac/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# FZF key bindings and completion (if available)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# bash-preexec for command suggestions (install: brew install bash-preexec)
[[ -f /opt/homebrew/etc/profile.d/bash-preexec.sh ]] && . /opt/homebrew/etc/profile.d/bash-preexec.sh

# hstr - bash history suggest box (install: brew install hstr)
if command -v hstr &> /dev/null; then
    export HSTR_CONFIG=hicolor,prompt-bottom
    bind '"\C-r": "\C-a hstr -- \C-j"'
    bind '"\C-xk": "\C-a hstr -k \C-j"'
fi
