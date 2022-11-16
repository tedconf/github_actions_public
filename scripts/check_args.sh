#! /bin/bash

# A very simple library to be sourced by any other bash script that globally
# searches and replaces gitrefs in this repo, to ensure that the new version is
# passed in on the command line.

if [ $# == 0 ]; then
  echo "You need to specify the version to update to on the command line!"
  echo "Usage: $0 [VERSION]"
  echo
  echo "Aborting..."
  exit 1
fi
