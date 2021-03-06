# If not running interactively, don't do anything
[ -z "$PS1" ] && return

echo "   ______   ___ __________
  / __/ /  / _ /_  __/ __/
 _\ \/ /__/ __ |/ / / _/  
/___/____/_/ |_/_/ /___/ "

echo

echo "Welcome to the interactive SLATE sandbox!"
echo

echo "Try \"slate --help\" to get started!"

cd $HOME

mkdir -p $HOME/.slate

if [ ! -z "$SLATE_API_ENDPOINT" ]; then
  echo $SLATE_API_ENDPOINT > $HOME/.slate/endpoint
fi

if [ ! -z "$SLATE_TOKEN" ]; then
  echo $SLATE_TOKEN > $HOME/.slate/token
fi

chmod 600 $HOME/.slate/token

slate completion bash > $HOME/.slate/completion.bash
if [ -f "$HOME/.slate/completion.bash" ]; then
  . $HOME/.slate/completion.bash
fi

PS1="\H:\w $ "
