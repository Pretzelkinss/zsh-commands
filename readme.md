# Pretzel's aliases and functions

This is a collection of aliases and functions that I have made for myself, but you may find useful for something.

These scripts as of today do not use any zsh functions; you should be able to use them with bash too, if you want to. But, I use zsh.

## Initial Setup

The scheme used here uses a loop in .zshrc to iterate through a subfolder in your $HOME directory, and add aliases or functions defined in .zsh files to your shell.

### Installation

make the script setup_zsh_aliases.sh executable via the command: 

'''sudo chmod +x setup_zsh_aliases.sh'''

run the script -if you accept the prompts, it will place a loop in your .zshrc file to find and load the aliases and functions. To use the aliases and functions in this repository, add them to the subfolder as shown below.

'''
/home/myuser/.zsh_aliases/
    ├── public_aliases.zsh
    └── public_functions.zsh
'''

After placing the files, run '''source ~/.zshrc''' to refresh your zsh shell without rebooting - the aliases in the specified files should now be available to you.

## Additional Considerations

You may want to define aliases or functions that you want to keep private - to do this, simple create a file in the .zsh_aliases folder with the zsh extension and define them inside that file - eg, my-private-aliases.zsh
When the loop in .zshrc runs, it should grab the aliases you defined. You can add as many such definition files as you want.
