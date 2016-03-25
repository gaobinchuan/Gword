#/bin/bash
if [[ ! -d $HOME/.Gwords/mp3 ]]; then
    mkdir -p $HOME/.Gwords/mp3
fi

if [[ -d $HOME/.gread ]]; then
    mv $HOME/.gread/* $HOME/.Gwords/mp3
fi

if [[ $1 ]]; then
    iconv -f GB18030 -t utf-8 lib/pet/Lesson\ ${1}.lrc | sed '1,8d' | sed 's/\ /\n/' | sed 's/\[.*\]//' > $HOME/.Gwords/list.txt
else
    cp -f ./lib/list.txt $HOME/.Gwords/list.txt
fi

if [[ `uname` == 'Darwin' || `uname` == 'darwin' ]]; then
    haveBashrc=`grep "HOME/.bashrc" $HOME/.bash_profile | wc -l`
    if [[ $haveBashrc -lt 2 ]]; then
        echo '' >> $HOME/.bash_profile
        echo '# To source .bashrc file' >> $HOME/.bash_profile
        echo 'if [ -f "$HOME/.bashrc" ]; then' >> $HOME/.bash_profile
        echo '  source "$HOME/.bashrc"' >> $HOME/.bash_profile
        echo 'fi' >> $HOME/.bash_profile
    fi
fi

haveEnv=`grep "HOME/.env" $HOME/.bashrc | wc -l`
if [[ $haveEnv -lt 2 ]]; then
    echo '' >> $HOME/.bashrc
    echo '# export user customized environment variables' >> $HOME/.bashrc
    echo 'if [ -f "$HOME/.env" ]; then' >> $HOME/.bashrc
    echo '  source "$HOME/.env"' >> $HOME/.bashrc
    echo 'fi' >> $HOME/.bashrc
fi

havePrompt=`grep "HOME/.prompt" $HOME/.env | wc -l`
if [[ $havePrompt -lt 2 ]]; then
    echo '' >> $HOME/.bashrc
    echo 'if [ -f "$HOME/.prompt" ]; then' >> $HOME/.env
    echo '  source "$HOME/.prompt"' >> $HOME/.env
    echo 'fi' >> $HOME/.env
fi
havePrompt=`grep "HOME/.Gwords" $HOME/.env | wc -l`
if [[ $havePrompt -lt 2 ]]; then
    echo '' >> $HOME/.env
    echo 'PATH=$HOME/.Gwords:$PATH' >> $HOME/.env
fi

cp ./lib/ps1 $HOME/.prompt

sudo cp ./lib/gr $HOME/.Gwords
sudo cp ./lib/gd $HOME/.Gwords
sudo cp ./lib/gw $HOME/.Gwords
sudo cp ./lib/grecite $HOME/.Gwords

if ! [[ `uname` == 'Darwin' || `uname` == 'darwin' ]]; then
    echo "Install MPlayer"
    sudo apt-get install mplayer
fi

echo "Reading the list"
echo "You can press ctrl-C to terminate the process."
source $HOME/.env
bash ./lib/mkvoice.sh
