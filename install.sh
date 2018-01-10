#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="ackrc agignore ctags gitconfig inputrc my.cnf tmux vim zsh dircolors"

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
   if [ -e ~/.$file ]
   then
      if [ -h ~/.$file ]
      then
         echo "Removing existing symlink ~/.$file"
         rm ~/.$file
      else
         if [ ! -e $olddir ]
         then
            # create dotfiles_old in homedir
            echo "Creating $olddir for backup of existing dotfiles"
            mkdir -p $olddir
         fi
         echo "Moving existing ~/.$file to $olddir"
         mv ~/.$file $olddir/$file
      fi
   fi
   echo "Creating symlink to $file in home directory."
   ln -s $dir/$file ~/.$file
done
