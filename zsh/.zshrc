# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# it can not search the file outside that directory
#cddir() {
#  cd "$(find . -type d | fzf)"
#}

# it can search the file outside the directory
cddir() {
    local base_dir="${1:-$HOME}"  # Default to ~ if no input
    base_dir="${base_dir/#\~/$HOME}"  # Expand ~

    # Check if the base dir exists
    if [[ ! -d "$base_dir" ]]; then
        echo "❌ '$base_dir' is not a valid directory"
        return 1
    fi

    # Use fzf to search for subdirectories
    local dir
    dir=$(find "$base_dir" -type d 2>/dev/null | fzf --prompt="📁 Pick a folder: ")

    # If a directory was selected, cd into it
    if [[ -n "$dir" ]]; then
        cd "$dir" || echo "❌ Failed to cd into $dir"
    else
        echo "⚠️ Cancelled"
    fi
}


# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"

# Optional: disable compfix warning (do this early)
ZSH_DISABLE_COMPFIX=true

# Plugins (DO NOT include zsh-autosuggestions here)
plugins=(
  git
  zsh-syntax-highlighting
  fzf
  z
  extract
  web-search
)

# Load Oh My Zsh (must come BEFORE binding keys)
source $ZSH/oh-my-zsh.sh

# Manually source autosuggestions (after Oh My Zsh)
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh



# search a file with preview and open with nvim 
alias openWithNvim='nvim $(fzf -m --preview="bat --color=always {}")'
alias ls='ls -p --color=auto'
alias la='eza -la'
alias cat='bat'
alias c='clear'
EDITOR='nvim'

# Enable help command in zsh
autoload -Uz run-help
alias help=run-help



# Make TAB accept autosuggestions
# Restore default Right Arrow behavior
bindkey '^[[C' forward-char

# Make Left Arrow accept the suggestion
bindkey '^[[D' autosuggest-accept
# User configuration

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

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
  # dir=$(dirname "$file")

  javac "$folder"/*.java && java -cp "$folder" "$class"
}


export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Disabled automatic pyenv init to stop per-shell auto-activation of Python
# If you want to re-enable pyenv initialization, uncomment the two lines below.
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
export JAVA_HOME=/opt/homebrew/Cellar/openjdk/25

# enable 24-bit color in terminal
export TERM=xterm-256color
export COLORTERM=truecolor
export PATH="/opt/homebrew/bin:$PATH"
export CPLEX_HOME=/Users/Inz_mac/Applications/CPLEX_Studio_Community2212/cplex
export DYLD_LIBRARY_PATH=$CPLEX_HOME/lib/arm64_osx/static_pic:$DYLD_LIBRARY_PATH
export PATH=$CPLEX_HOME/bin:$PATH


# Added by Antigravity
export PATH="/Users/Inz_mac/.antigravity/antigravity/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/Inz_mac/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
# <<< conda initialize <<<
