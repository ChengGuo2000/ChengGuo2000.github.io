#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

PORTABLE_RUBY="${PORTABLE_RUBY:-/usr/local/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin}"

if [ ! -x "$PORTABLE_RUBY/ruby" ] || [ ! -x "$PORTABLE_RUBY/gem" ]; then
  echo "Homebrew portable Ruby was not found at: $PORTABLE_RUBY" >&2
  echo "Run 'brew update' once, or set PORTABLE_RUBY to a Ruby bin directory." >&2
  exit 1
fi

export GEM_HOME="$PWD/.ruby-gems"
export GEM_PATH="$GEM_HOME"
export PATH="$GEM_HOME/bin:$PORTABLE_RUBY:/usr/bin:/bin:/usr/sbin:/sbin"
export RUBYOPT="-r./scripts/ruby4_jekyll_compat${RUBYOPT:+ $RUBYOPT}"

if ! command -v bundle >/dev/null 2>&1; then
  gem install bundler --no-document
fi

bundle config set --local path 'vendor/bundle'
bundle install
bundle exec jekyll serve -H localhost --port "${PORT:-4000}" "$@"
