if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
    set -gx TERM xterm-256color
    # theme
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_display_user yes
    set -g theme_hide_hostname no
    set -g theme_hostname always
    # aliases
    alias ls "ls -p -G"
    alias la "ls -A"
    alias ll "exa -l -g --icons"
    alias lla "ll -a"
    alias g git
    alias vim nvim
    alias v vim

    set -gx EDITOR nvim

    set -gx PATH bin $PATH
    set -gx PATH ~/bin $PATH
    set -gx PATH ~/.local/bin $PATH

    # NodeJS
    set -gx PATH node_modules/.bin $PATH

    # Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    fish_add_path /opt/homebrew/opt/openjdk/bin

    #Python
    pyenv init - | source

    # Fzf
    set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
    set -g FZF_LEGACY_KEYBINDINGS 0
end
