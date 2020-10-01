# System-wide profile for interactive zsh(1) shells.

# Setup user specific overrides for this in ~/.zhsrc. See zshbuiltins(1)
# and zshoptions(1) for more details.

# Correctly display UTF-8 with combining characters.
if [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
    setopt COMBINING_CHARS
fi

# Disable the log builtin, so we don't conflict with /usr/bin/log
disable log

# Save command history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=4000
SAVEHIST=2000

# Beep on error
setopt BEEP

# 重複コマンドをhistoryに残さない
setopt HIST_IGNORE_DUPS


autoload -U compinit
compinit -u

# Use keycodes (generated via zkbd) if present, otherwise fallback on
# values from terminfo
if [[ -r ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR} ]] ; then
    source ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR}
else
    typeset -g -A key

    [[ -n "$terminfo[kf1]" ]] && key[F1]=$terminfo[kf1]
    [[ -n "$terminfo[kf2]" ]] && key[F2]=$terminfo[kf2]
    [[ -n "$terminfo[kf3]" ]] && key[F3]=$terminfo[kf3]
    [[ -n "$terminfo[kf4]" ]] && key[F4]=$terminfo[kf4]
    [[ -n "$terminfo[kf5]" ]] && key[F5]=$terminfo[kf5]
    [[ -n "$terminfo[kf6]" ]] && key[F6]=$terminfo[kf6]
    [[ -n "$terminfo[kf7]" ]] && key[F7]=$terminfo[kf7]
    [[ -n "$terminfo[kf8]" ]] && key[F8]=$terminfo[kf8]
    [[ -n "$terminfo[kf9]" ]] && key[F9]=$terminfo[kf9]
    [[ -n "$terminfo[kf10]" ]] && key[F10]=$terminfo[kf10]
    [[ -n "$terminfo[kf11]" ]] && key[F11]=$terminfo[kf11]
    [[ -n "$terminfo[kf12]" ]] && key[F12]=$terminfo[kf12]
    [[ -n "$terminfo[kf13]" ]] && key[F13]=$terminfo[kf13]
    [[ -n "$terminfo[kf14]" ]] && key[F14]=$terminfo[kf14]
    [[ -n "$terminfo[kf15]" ]] && key[F15]=$terminfo[kf15]
    [[ -n "$terminfo[kf16]" ]] && key[F16]=$terminfo[kf16]
    [[ -n "$terminfo[kf17]" ]] && key[F17]=$terminfo[kf17]
    [[ -n "$terminfo[kf18]" ]] && key[F18]=$terminfo[kf18]
    [[ -n "$terminfo[kf19]" ]] && key[F19]=$terminfo[kf19]
    [[ -n "$terminfo[kf20]" ]] && key[F20]=$terminfo[kf20]
    [[ -n "$terminfo[kbs]" ]] && key[Backspace]=$terminfo[kbs]
    [[ -n "$terminfo[kich1]" ]] && key[Insert]=$terminfo[kich1]
    [[ -n "$terminfo[kdch1]" ]] && key[Delete]=$terminfo[kdch1]
    [[ -n "$terminfo[khome]" ]] && key[Home]=$terminfo[khome]
    [[ -n "$terminfo[kend]" ]] && key[End]=$terminfo[kend]
    [[ -n "$terminfo[kpp]" ]] && key[PageUp]=$terminfo[kpp]
    [[ -n "$terminfo[knp]" ]] && key[PageDown]=$terminfo[knp]
    [[ -n "$terminfo[kcuu1]" ]] && key[Up]=$terminfo[kcuu1]
    [[ -n "$terminfo[kcub1]" ]] && key[Left]=$terminfo[kcub1]
    [[ -n "$terminfo[kcud1]" ]] && key[Down]=$terminfo[kcud1]
    [[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]
fi

# Default key bindings
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search


function exit-code-emoticon()
{
    if [ $EXIT_CODE -eq 0 ]
    then
        echo -n "(\`･ω ･´)b [$EXIT_CODE]"
    else
        echo -n "(´･ω ･\`)p [$EXIT_CODE]"
    fi
}

# Useful support for interacting with Terminal.app or other terminal programs
[ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"

#fzfの表示を上側にする
export FZF_DEFAULT_OPTS="--reverse"
ENHANCD_FILTER=fzf:peco:fzy

#ターミナルの見た目を通常通りにする
export TERM='xterm-256color'

#Gitのブランチの状態をプロンプトに表示する
function prompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status=""
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態?
    branch_status="%F{207}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態+
    branch_status="%F{207}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態×
    branch_status="%F{009}"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo " %F{238} $branch_name ${branch_status}%f"
}

#Gitのブランチの状態をプロンプトの右端に表示
function prompt-git-current-branch-2 {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{048}\(._.)"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{160}?(._.)"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{160}+(._.)"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{226}!(･口･)"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}


# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# cool prompt
PROMPT_Apple='%K{238}%F{255}  %f%k%K{039}%F{238}%f%k%K{039}%F{238} %f%k'
PROMPT_DIR='%K{039}%F{238} %~ %f%k'
PROMPT_GIT='%K{214}%F{039}%f%F{238} %f'
# 普通の時の背景は235 solarizedを使う時は0
PROMPT_end='%F{214}%k%K{0}%k%f'
# PROMPT='$PROMPT_Apple$PROMPT_DIR$PROMPT_GIT $(prompt-git-current-branch) $PROMPT_end
# %F{051}❯%f%F{123}❯%f%F{165}❯%f '
# cool rprompt
# 普通の時は235 solarizedの時は0
RPROMPT_check='%K{0}%F{238}%f%k%K{238}%(?!%F{034}  %f!%F{160}  %f)%F{white}%f'
RPROMPT_time='%K{white}%F{238} %@ %f%k'
# RPROMPT='$RPROMPT_check$RPROMPT_time'

# simple prompt
# PROMPT='%F{027}%n%f %F{087}%~%f
# %F{051}❯%f%F{123}❯%f%F{165}❯%f '

# cute prompt
# PROMPT='%F{197}[%f%F{009}%n%f:%F{190}%~%f%F{197}]%f $(prompt-git-current-branch-2)
# %F{046}%B%(?!\(._.)/%f!%F{009}?(;_;%)?)%b%f%F{212}$%f '

# kumasan prompt
PROMPT_GitS='%K{255}%F{238} %f'
PROMPT_GitE='%F{255}%k%K{050}%k%f'
PROMPT_Dir='%K{050}%F{238} %~ %f%k%F{050}%k%K{0}%k%f'
PROMPT_KUMA_1='%(?!%F{015}ʕ •ɷ• ʔ %f!%F{160}ʕ •ﻌ•; ʔ %f)'
PROMPT_KUMA_2='%(?!%F{015}ʕ`•ᴥ•´ʔ %f!%F{160}ʕ •ﻌ•; ʔ %f)'
PROMPT='$PROMPT_GitS $(prompt-git-current-branch) $PROMPT_GitE$PROMPT_Dir
$PROMPT_KUMA_2'



# aliases
alias ls="lsd"
#alias ls='gls --color=auto'
#alias ls="ls -G"
alias cat="bat"
alias blueterm="blueterm -b"
alias webdir="mkdir html css js fonts"
alias cargo_update="cargo install-update --all"

# 失敗したコマンドを履歴に残さない
__record_command() {
  typeset -g _LASTCMD=${1%%$'\n'}
  return 1
}
zshaddhistory_functions+=(__record_command)

__update_history() {
  local last_status="$?"

  # hist_ignore_space
  if [[ ! -n ${_LASTCMD%% *} ]]; then
    return
  fi

  # hist_reduce_blanks
  local cmd_reduce_blanks=$(echo ${_LASTCMD} | tr -s ' ')

  # Record the commands that have succeeded
  if [[ ${last_status} == 0 ]]; then
    print -sr -- "${cmd_reduce_blanks}"
  fi
}
precmd_functions+=(__update_history)

#git log的なあれ
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

#zshrcが変更されたらzcompileする
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

#precmd
function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

#tmux起動時に名前をつける
if [ ! -z $TMUX ]; then
    tmux show-options | grep "TMUX_NO_FORCE_NAME_SESSION" > /dev/null
    if [ $? -ne 0 ]; then
        SESSION_NAME=`tmux display-message -p '#S'`
        echo $SESSION_NAME | grep "^[0-9]\+$" > /dev/null
        if [ $? -eq 0 ]; then   # Not named
            /bin/echo -n "tmux session name: "
            read NAME
            if [ ! -z $NAME ]; then
                tmux rename-session $NAME
            else
                tmux set-option update-environment TMUX_NO_FORCE_NAME_SESSION=1
            fi
        fi
    fi
fi

#jenv
eval "$(jenv init -)"

# githubを補完する
eval "$(gh completion -s zsh)"

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 80% --reverse --border'

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
zinit light momo-lab/zsh-abbrev-alias # 略語を展開する
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/history-search-multi-word
zinit light paulirish/git-open
zinit light b4b4r07/enhancd
