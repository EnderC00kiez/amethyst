echo "Amethyst will not check for privileges and may ask for your password."
sudo echo "===== Setup ====="
# check if Python is installed
if ! [ -x "$(command -v python3)" ]; then
    echo "Python is not installed. Installing it will additionally add the deadsnakes PPA to your system. Would you like to install it? (y/n)"
    read -r answer
    # add deadsnakes ppa
    if [ "$answer" = "y" ]; then
        echo "Adding PPA"
        sudo apt-add-repository ppa:deadsnakes/ppa
        echo "Refreshing package list"
        sudo apt update
        echo "Installing Python 3.10"
        sudo apt install python3.10
    else
        echo "Amethyst requires Python."
        exit 1
    fi
fi

# check if Ruby is installed
if ! [ -x "$(command -v ruby)" ]; then
    echo "Ruby is not installed. The installer can install it through RVM or rbenv. Would you like to install it? (y/n)"
    read -r answer
    # add rvm ppa
    if [ "$answer" = "y" ]; then
        echo "Would you like to install RVM or rbenv? (rvm/RBENV)"
        read -r answer
        if [ "$answer" = "rvm" ]; then
            echo "Installing RVM"
            gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
            \curl -sSL https://get.rvm.io | bash -s stable
            source ~/.bashrc
            rvm install 3.1.2
            rvm use 3.1.2 --default
            echo "Ruby has been installed through RVM."
        else
            echo "Installing rbenv"
            sudo apt install rbenv
            echo "Installing Ruby 3.1.2"
            rbenv init
            rbenv install 3.1.2
        fi
    else
        echo "Amethyst requires Ruby."
        exit 1
    fi
fi