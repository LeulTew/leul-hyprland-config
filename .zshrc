# ======================================
#        Fedora / Hyprland Zsh
# ======================================

# --- Terminal & Editor ---
export TERM=xterm-256color
export EDITOR='nvim'
export PATH="$HOME/.local/bin:$PATH"

# --- History settings (Fish-like) ---
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt AUTO_CD
setopt INC_APPEND_HISTORY

# --- Keybindings (Fish style up/down search) ---
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey '^[[C' autosuggest-accept

# --- Plugins ---
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Starship prompt ---
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# --- FZF keybindings ---
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && \
    source /usr/share/fzf/shell/key-bindings.zsh

# --- Custom Aliases ---
alias v='nvim'
alias ff='fastfetch'
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias y='yazi'
alias grep='grep --color=auto'

# opencode
export PATH=/home/leul/.opencode/bin:$PATH
