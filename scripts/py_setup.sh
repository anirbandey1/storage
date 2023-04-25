#!/bin/sh

# Script to create virtual environment for testing using python venv module

check_core_dependencies () {

    if ! command -v git >/dev/null 2>&1; then
        echo "Git is not installed"
        exit 1
    elif ! command -v python3 >/dev/null 2>&1; then
        echo "Python 3 is not installed"
        exit 1
    elif ! command -v pip3 >/dev/null 2>&1; then
        echo "Pip 3 is not installed"
        exit 1
    else 
        echo "You have most of the dependencies installed"
        git --version
        python3 --version
        pip3 --version

        echo "NOTE !!!"
        echo ""
        echo "On Debian, you must have python3.10-venv or higher installed"
        echo "On RHEL/Fedora, you must have python3-venv installed"
        echo ""
    fi
}


create_venv () {



    # cd into the root directory of git repo
    cd $(git rev-parse --show-toplevel)
    echo -n "You are currently in "
    pwd


    echo "Using venv to create a virtual environment..."
    python3 -m venv venv
    

    if [ ! -f venv/bin/activate ]; then
        echo "ERROR: Virtual environment not found." 
        echo "Please create a virtual environment first."
        exit 1
    else 
        echo "Virtual Environment has been created"
        echo "Activating the Virtual Environment"
        # source venv/bin/activate
        . venv/bin/activate
    fi

    # check versions
    echo -n "python3 being used is "
    which python3
    python3 --version
    echo -n "pip3 being used is "
    which pip3
    pip3 --version

    echo -n "Do you want to install all the python dependencites? (y/n) "
    read answer

    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        pip3 install -r requirements.txt
    fi


    echo "Pip modules installed"
    pip freeze

    echo -n "Number of pip modules installed "
    pip freeze | wc -l
}


check_core_dependencies
create_venv





