# ~/.config/fish/config.fish

# Set default editor
set -Ux EDITOR "nvim"
set -Ux VISUAL "nvim"
set -Ux MANPAGER "nvim +Man!"
set -Ux PAGER "less"

# Set PATH variables
{{ if eq .chezmoi.os "darwin" }}
    set -gx PATH "/opt/homebrew/bin" $PATH
{{ else }}
    set -gx PATH "$HOME/.nix-profile/bin" $PATH
{{ end }}

set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH $PNPM_HOME/bin $HOME/.local/bin $HOME/.yarn/bin $HOME/.cargo/bin $PATH

# Shell aliases
alias ls "eza --group-directories-first"
alias pn "pnpm"
alias tmux "tmux -f ~/.config/tmux/tmux.conf"
alias rook "~/projects/rook/tools/rook"

{{ if eq .chezmoi.os "linux" }}
    alias vpn "sudo openconnect --background --protocol=gp vpn.praeses.com; and echo 'restarting sssd'; and sudo systemctl restart sssd"
{{ else }}
    # TODO: Set up OpenConnect VPN for macOS when details are available
{{ end }}

# SSH Agent setup
{{ if eq .chezmoi.os "darwin" }}
    # macOS: Use built-in Keychain for SSH key management
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null
    ssh-add --apple-use-keychain ~/.ssh/work_key 2>/dev/null
{{ else }}
    # Linux: Use keychain for persistent SSH keys
    if test -z "$SSH_AUTH_SOCK"
        eval (keychain --eval --agents ssh ~/.ssh/id_ed25519 ~/.ssh/work_key)
    end
{{ end }}

# Monokai Fish shell theme
set -g fish_color_normal F8F8F2
set -g fish_color_command A6E22E
set -g fish_color_quote E6DB74
set -g fish_color_redirection AE81FF
set -g fish_color_end F8F8F2
set -g fish_color_error F92672 --background=default
set -g fish_color_param A6E22E
set -g fish_color_comment 75715E
set -g fish_color_match F8F8F2
set -g fish_color_search_match --background=49483E
set -g fish_color_operator AE81FF
set -g fish_color_escape 66D9EF
set -g fish_color_cwd 66D9EF

# Completion Pager Colors
set -g fish_pager_color_prefix F8F8F2
set -g fish_pager_color_completion 75715E
set -g fish_pager_color_description 49483E
set -g fish_pager_color_progress F8F8F2
set -g fish_pager_color_secondary F8F8F2

# Gitignore.io function
function gi
    curl -sL https://www.gitignore.io/api/$argv
end

