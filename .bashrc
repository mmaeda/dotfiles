#!bin/bash
set -o vi

alias la='ls -alG'
alias al='ls -alG'

alias ll='ls -lG'

alias git='/usr/local/Cellar/git/1.8.0.2/bin/git'

# プロンプトの表示
export PS1="\[\033[0;36m\][ \u@\H ] \[\033[0;32m\]\W\[\033[0;39m\] $ " 

# デフォルトの色から少しカスタマイズ
#export LSCOLORS=exfxcxdxbxegedabagacad
export LSCOLORS=gxfxcxdxbxegedabagacad

# Bazaar用にpython2.6を使用
defaults write com.apple.versioner.python Version 2.6

