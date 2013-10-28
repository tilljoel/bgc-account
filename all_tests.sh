#!/bin/zsh
export RUBY=`rbenv which ruby`

# Simple way to run all tests standalone, just to make sure they work when I
# trigger them from my editor

for file in test/**/test_*.rb
do
  if test -f "$file"
  then
    echo "Run tests in: #${file}"
    $RUBY -Itest $file;
  fi
done
