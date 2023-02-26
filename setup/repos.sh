#!/bin/sh
echo "Cloning repositories..."

LOCAL=$HOME/Local
PROJECTS=$HOME/Local/Projects
BEN=$PROJECTS/Ben
MATRIX=$PROJECTS/Matrix

# Personal
git clone git@github.com.ben:benhaldenby/dotfiles.git $BEN

# Matrix
git clone git@github.com:MatrixCreate/craft-starter.git $MATRIX
git clone git@github.com:MatrixCreate/matrix.git $MATRIX
git clone git@bitbucket.org:matrixcreate/affinity-devon.git $MATRIX
