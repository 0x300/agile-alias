#!/bin/bash

# Helper for getting y/n choice
# Based on example from Bash Cookbook
function choice {
    CHOICE=''
    local prompt="$*"
    local answer
    read -p "$prompt" answer
    case "$answer" in
        [yY] ) CHOICE='y';;
        [nN] ) CHOICE='n';;
            * ) CHOICE="$answer";;
    esac
}

ALIAS_FILES="$HOME/.agile_aliases $HOME/.bashrc $HOME/.aliases"
PS3="Select file to add alias to: "
select SELECTED_FILE in $ALIAS_FILES; do
    until [ "$CHOICE" = "n" ]; do
        printf "\n==============================\n\n"
        read -p "Alias name: " ALIAS_NAME
        read -p "Alias content: " ALIAS_CONTENT

        printf "\nAdding alias to $SELECTED_FILE:\n"
        printf "alias $ALIAS_NAME=\"$ALIAS_CONTENT\"\n\n"

        echo "alias $ALIAS_NAME=\"$ALIAS_CONTENT\"" >> $SELECTED_FILE
        source $SELECTED_FILE

        choice "Add another? y/N: "

        # Defaults no reponse to exit, else continue looping
        if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y" ]; then
            : # noop
        else
            # Default action for any non-yes response
            exit
        fi
    done
done
