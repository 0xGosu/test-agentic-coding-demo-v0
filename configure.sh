#!/bin/bash
# create kiro dir if it does not yet exist
if [ ! -d ".kiro" ]; then
  mkdir .kiro
fi
# create symlink for .kiro/specs to the docs/specs directory (support Kiro IDE)
[ -L ".kiro/specs" ] || (mv .kiro/specs .kiro/.specs; ln -fs ../docs/specs .kiro/specs)

# set up env files from default file
[ -f ".env" ] || cp default.env .env

# TODO: add more setup steps here

echo "This script sets up all system config/files required to run the project"