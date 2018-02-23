echo -e "Currently logged in user : $(whoami)" '\n'
echo -e "Currently using shell :" $SHELL '\n'
echo -e "Home Directory :" $HOME '\n'
echo -e "Operating System Type : $(uname -o)" '\n'
echo -e "Current path settings :" $PATH '\n'
echo -e "Current Working Directory : $(pwd)" '\n'
echo -e "Number of users logged in: $(who -q | tail -n 1)"
