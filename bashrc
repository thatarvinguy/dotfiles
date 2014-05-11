#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#Path variable
export PATH=$PATH:/opt/android-sdk/tools/:/opt/android-sdk/platform-tools/:/opt/android-studio/bin
