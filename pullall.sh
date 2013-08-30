#!/bin/sh
# Update all source code in ~/src dir

for i in `ls`; do
        if [ -d $i ]; then
                cd $i
                echo -e "\e[0;32m$i\e[0m"
                if [ -d ".git" ]; then
                        git checkout master
                        git pull
                elif [ -d ".svn" ]; then
                        svn update
                elif [ -d ".bzr" ]; then
                        bzr pull
                fi
                cd ..
        fi
done
