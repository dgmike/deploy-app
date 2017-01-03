#!/bin/bash --login

if type rbenv > /dev/null 2>&1; then
  declare -r RUBY_VERSION_MANAGER=rbenv
  echo USING RBENV
fi

if type rvm > /dev/null 2>&1; then
  declare -r RUBY_VERSION_MANAGER=rvm
  echo USING RVM
fi

if [ -f .ruby-version ]; then
  if [[ "${RUBY_VERSION_MANAGER}" == "rbenv" ]]; then
    rbenv local > /dev/null
    rbenv install -s
    rbenv rehash
  elif [[ "${RUBY_VERSION_MANAGER}" == "rvm" ]]; then
    rvm use $(cat .ruby-version) --install
  fi

  DECLARED_RUBY_VERSION=`cat .ruby-version`
  echo RUBY VERSION: ${DECLARED_RUBY_VERSION}
fi

# install again, over ruby version
gem install step-up

if [ -f Gemfile ]; then
  gem install bundler
fi
