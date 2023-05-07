#!/bin/sh
echo "Cloning repositories..."

LOCAL=$HOME/Local
BEN=$LOCAL/Ben
MATRIX=$LOCAL/Matrix

# Personal
git clone git@github.com.ben:benhaldenby/dotfiles.git $BEN

# Matrix
git clone git@github.com:MatrixCreate/craft-starter.git $MATRIX
git clone git@github.com:MatrixCreate/matrix.git $MATRIX
git clone git@bitbucket.org:matrixcreate/affinity-devon.git $MATRIX
