# If not running interactively, don't do anything
[ -z "$PS1" ] && return

echo "Welcome to the SLATE interactive sandbox!"

cd $HOME

mkdir -p $HOME/.slate

if [ ! -z "$SLATE_API_ENDPOINT" ]; then
  echo $SLATE_API_ENDPOINT > $HOME/.slate/endpoint
fi

if [ ! -z "$SLATE_TOKEN" ]; then
  echo $SLATE_TOKEN > $HOME/.slate/token
fi

chmod 600 $HOME/.slate/token



PS1="[\A] \H:\w $ "