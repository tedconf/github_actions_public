#! /bin/bash
. scripts/check_args.sh

find .github/workflows -type f -name "rails*.yml" |
  xargs perl -i -pe "s#tedconf/setup-ruby\@\S+#tedconf/setup-ruby\@$1#"
