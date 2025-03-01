set -g fish_greeting
set -g HOMEBREW_NO_ENV_HINTS
set -Ux EDITOR nvim
set -gx RUNEWIDTH_EASTASIAN 0

set PATH /opt/homebrew/bin /opt/homebrew/sbin ~/.local/bin /snap/bin /usr/sandbox/ /usr/local/bin /usr/bin /bin /usr/local/games /usr/games /usr/share/games /usr/local/sbin /usr/sbin /sbin ~/.cargo/bin ~/go/bin $PATH

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command "#00ff5f" "--bold"
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

# custom search for web-search
set -gx WEB_SEARCH_dict 'https://dictionary.cambridge.org/dictionary/english-chinese-traditional/'
set -gx WEB_SEARCH_longman 'https://www.ldoceonline.com/dictionary/'

# bat for man
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# aliases - general
alias la='ls -lAh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lg='lazygit'
alias vv="bangs vocabulary"
alias w1='curl v2.wttr.in/taipei'
alias w2="curl wttr.in/中山區\?lang=zh-tw"
alias hn="hackernews_tui"
alias sp="spotify_player"

# aliases -- tmux (syntax: alias [,command])
alias tp='tmux popup -E -E -w 80% -h 80% -b rounded -S \'fg=yellow\''
alias tn='tmux neww -a' # create a new temporary window

# aliases - web-search
alias google='web-search google'
alias stackoverflow='web-search stackoverflow'
alias github='web-search github'
alias ddg='web-search duckduckgo'
alias brs='web-search brave'
alias youtube='web-search youtube'
alias dict='web-search dict'
alias longman='web-search longman'

# alias - duckduckgo bangs
alias wiki='bangs w'
alias image='bangs gi'
alias map='bangs m'
alias ducky='bangs'

function bangs -d 'duckduckgo bangs'
  set -l url 'https://duckduckgo.com/?q=!'
  if test (count $argv) -gt 1
    open $url$argv[1]+(string join + $argv[2..-1])
  else 
    open $url$argv
  end
end

# Add vocabulary to my vocabulary.md
# TODO:
# add gist sync
# goruping by first letter for future development

function voca -d "Manage your vocabulary box"
  argparse --stop-nonopt e/edit l/list h/help d/dict 't/tail=?!_validate_int' -- $argv
  or return
  
  
  if set -ql _flag_help
    printf %s\n \
    'voca - manage your vocabulary box' \
    'Usage: voca [WORD ...]' \
    'Options:' \
    '  -e or --edit: edit the vocabulary box' \
    '  -d or --dict: select a word and look it up in a dictionary' \
    '  -l or --list: list all words in the box' \
    '  -t[NUM] or --tail[=NUM]: list the last N numbers of words in the box (default is 10)' \
    '  -h or --help: print this help message'
    return 0
  end
  
  if set -ql _flag_list
    if not test -f ~/.vocabularybox; or not test -s ~/.vocabularybox
      echo 'vocabulary box does not exist or empty. Use "voca [WORD ...]" to add words.'
      return 0
    end
    cat ~/.vocabularybox | fzf
    return 0
  end

  if set -ql _flag_edit
    nvim ~/.vocabularybox
    return 0
  end

  if set -ql _flag_dict
    printf %s\n \
    'select dictionary by number:' \
    '1) vocabulary.com' \
    '2) longman' \
    '3) urban dictionary' \
    '4) cambridge dictionary'
    set -l cmd bangs vocabulary 
    while read -l dictionary -P "> "
      switch $dictionary
        case 1
        case 2
          set cmd longman
        case 3
          set cmd web-search urbandict
        case 4
          set cmd dict
        case '*'
          echo 'using vocabulary.com (default)...'
          sleep 0.5
      end
      break
    end
    
    set -l word (cat ~/.vocabularybox | fzf)
    if test -z $word
      return 1
    end
    
    $cmd $word
    return 0
  end

  if set -ql _flag_tail
    if test -z $_flag_tail
      tail ~/.vocabularybox
    else
      tail -n $_flag_tail ~/.vocabularybox
    end
    return 0
  end

  _voca_add_words $argv
end

function _voca_add_words -d 'Add words to vocabulary box'
  if test (count $argv) -eq 0
    echo "No argument was passed. See \"voca -h\"."
    return
  end

  # TODO: add repeated word validation
  
  if test (count $argv) -eq 1
    echo $argv >> ~/.vocabularybox
  else
    for i in $argv
      echo $i >> ~/.vocabularybox
    end
  end
end

# aliases - cheat sheet
alias mdcs='open https://www.markdownguide.org/basic-syntax/'
alias vimcs='open https://vim.rtorr.com/lang/zh_tw'

# mdbooks
alias book-go="open ~/Desktop/mdbook/build-web-application-with-golang-zh_tw/book/index.html"

# fzf
set -g FZF_DEFAULT_OPTS "--scroll-off 3 --bind change:top --height 40% --reverse --color=border:#6ee7b7,spinner:#73d0ff,hl:#e1a676,fg:#cbccc6,header:#d4bfff,info:#73d0ff,pointer:#7dd3fc,marker:#E17899,fg+:#D9D9D9,prompt:#707a8c,hl+:#ffcc66,scrollbar:blue"

set -g FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}'
  --bind 'focus:transform-preview-label:echo {} | xargs basename'
  --border --border-label 'Files'
  --bind 'ctrl-/:change-preview-window(60%|down,60%|hidden)'"
set -g FZF_CTRL_R_OPTS "--reverse --preview 'echo {}' --preview-window down:3:wrap
  --border --border-label 'History'
  --color preview-fg:#e1a676
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {} | pbcopy)+abort'
  --color header:italic
  --header 'CTRL-Y: Copy command into clipboard; CTRL-/: Toggle preview'"
set -g FZF_ALT_C_OPTS "--preview 'tree -C {} | head -150'
  --border --border-label 'Directories'
  --bind 'ctrl-/:change-preview-window(50%|down,50%|hidden)'"
set -g FZF_TMUX_OPTS "-p 80%,70%"

zoxide init fish | source
navi widget fish | source # CTRL-G to trigger

# pnpm
set -gx PNPM_HOME "/Users/kentsmba/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by Windsurf
fish_add_path /Users/kentsmba/.codeium/windsurf/bin
