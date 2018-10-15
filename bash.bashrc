# If not running interactively, don't do anything
[ -z "$PS1" ] && return

echo "Welcome to the SLATE interactive sandbox!"

cd $HOME

PS1="[\A] \H:\w $ "
