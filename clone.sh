#!/bin/sh

echo "Cloning repositories..."

LOCAL=$HOME/Local
PROJECTS=$HOME/Local/Projects
BEN=$HOME/Local/Projects/Ben
MATRIX=$HOME/Local/Projects/Matrix

# Matrix
git clone git@github.com:MatrixCreate/craft-starter.git $MATRIX
git clone git@github.com:MatrixCreate/matrix.git $MATRIX
git clone git@bitbucket.org:matrixcreate/affinity-devon.git $MATRIX

# Personal
git clone git@github.com:benhaldenby/dotfiles.git $BEN
