#/bin/bash
if [[ ! -d $HOME/.Gwords ]]; then
    mkdir $HOME/.Gwords
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

cp ./lib/ps1 $HOME/.prompt

sudo cp ./lib/gr /usr/local/bin
sudo cp ./lib/gd /usr/local/bin
