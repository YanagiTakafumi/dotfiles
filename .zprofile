export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export JAVA_HOME=`/usr/libexec/java_home -v "14"`
export PATH=${JAVA_HOME}/bin:${PATH}
export JAVA_HOME=`/usr/libexec/java_home -v "11"`
export PATH=${JAVA_HOME}/bin:${PATH}
export PATH="$PATH:$HOME/bin"
eval "$(jenv init -)"
export PATH=$PATH:/Users/yanagitakafumi/opt/anaconda3/bin
alias python="python3"
#alias cat="bat"
#alias ls="ls -G"
#alias ls="exa"
eval `/usr/local/opt/coreutils/libexec/gnubin/dircolors ~/.dircolors-solarized/dircolors.ansi-dark`
#alias ls='gls --color=auto'
#alias tscreen="screen /dev/cu.usbserial-AI05V9J2"
alias webdir="mkdir html css js fonts"
alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew'
export PATH="$PATH:/usr/libexec"
alias man="man -C ~/.man.conf"
