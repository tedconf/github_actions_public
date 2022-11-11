if [ $# == 0 ]; then
  echo "You need to specify the version to update to on the command line!"
  echo "Usage: $0 [VERSION]"
  echo
  echo "Aborting..."
  exit 1
fi

find .github/workflows -type f -name "rails*.yml" | xargs perl -i -pe "s#tedconf/setup-ruby\@\S+#tedconf/setup-ruby\@$1#"
