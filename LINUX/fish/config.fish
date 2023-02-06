# function fish_greeting
#     toilet -F gay -f smslant hello world 
# end
set -g fish_greeting
set -Ux EDITOR nvim
set -gx RUNEWIDTH_EASTASIAN 0

function fish_prompt
    echo (set_color red)"┌["(set_color cyan)"$hostname"(set_color red)"]─["(set_color yellow)(date "+%H:%M-%d/%m")(set_color red)"]─["(set_color blue)"$PWD"(set_color red)"]"
    echo (set_color red)"└╼"(set_color green)"$USER"(set_color yellow)(set_color yellow)"\$"(set_color normal)
end

set PATH ~/.local/bin /snap/bin /usr/sandbox/ /usr/local/bin /usr/bin /bin /usr/local/games /usr/games /usr/share/games /usr/local/sbin /usr/sbin /sbin ~/.cargo/bin $PATH

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

#aliases
alias ls='exa'
alias la='ls -lah'
alias llt='exa --long --tree'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias bat='batcat'

# aliases - web-search
alias google='web-search google'
alias stackoverflow='web-search stackoverflow'
alias github='web-search github'
alias ddg='web-search duckduckgo'
alias brs='web-search brave'
alias youtube='web-search youtube'
alias wiki='web-search duckduckgo \!w'
alias map='web-search duckduckgo \!m'
alias image='web-search duckduckgo \!i'
alias ducky='web-search duckduckgo \!'
alias dict='web-search dict'
alias longman='web-search longman'

# aliases - others
alias mdcs='open https://www.markdownguide.org/basic-syntax/'
alias vimcs='open https://vim.rtorr.com/lang/zh_tw'

# fzf
set -g FZF_DEFAULT_OPTS "--scroll-off 3 --bind change:top --height 50% --reverse --color=border:#6B6B6B,spinner:#98BC99,hl:#68ca7c,fg:#D9D9D9,header:#719872,info:#BDBB72,pointer:#E12672,marker:#E17899,fg+:#D9D9D9,prompt:#98BEDE,hl+:#7ae471,scrollbar:blue"

set -g FZF_CTRL_T_OPTS "--preview 'batcat -n --color=always {}'
  --bind 'focus:transform-preview-label:echo {} | xargs basename'
  --border-label 'Files'
  --bind 'ctrl-/:change-preview-window(50%|down,60%|hidden)'"
set -g FZF_CTRL_R_OPTS "--reverse --preview 'echo {}' --preview-window down:3:wrap
  --border-label 'History'
  --color preview-fg:#e19758
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {} | xclip -sel clip)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
set -g FZF_ALT_C_OPTS "--preview 'tree -C {} | head -150'
  --border-label 'Directories'
  --bind 'ctrl-/:change-preview-window(50%|down,50%|hidden)'"
set -g FZF_TMUX_OPTS "-p 85%,60%"

zoxide init fish | source
starship init fish | source

