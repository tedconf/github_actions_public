#! /bin/bash
# Because this repo uses nested workflows, any new version will need to update
# the gitref when it references another workflow file that lives in this repo.
# This script facilitates those updates by searching for "rails*.yml" files and
# then replacing the old value with the new version (the latter of which is
# passed in as a command-line argument).
. scripts/check_args.sh

find .github/workflows -type f -name "rails*.yml" |
  xargs perl -i -pe "s#(?<=tedconf/github_actions_public/.github/workflows/)(rails\S+\@)\S+#\1$1#"
