#!/usr/bin/env bash

set -e

DOC_FOLDER="docs"
SITE_FOLDER="website"
BUNDLE_REPORT_FOLDER="bundle-report"

MAIN_BRANCH="setup-ci"
UPSTREAM="https://$GITHUB_TOKEN@github.com/$TRAVIS_REPO_SLUG.git"
MESSAGE="Republishing universe for revision $TRAVIS_COMMIT: $TRAVIS_COMMIT_MESSAGE"
AUTHOR="$USER <>"

if [ "$TRAVIS_PULL_REQUEST" != "false" ];then
  echo "Not republishing won't build on pull request"
  exit 0
fi

if [ "$TRAVIS_BRANCH" != "$MAIN_BRANCH" ];then
  echo "Not republishing : not on branch $MAIN_BRANCH"
  exit 0
fi

function setup() {
}

function publish() {

  mv target/universe.json universe.json

  git init
  git remote add upstream "$UPSTREAM"
  git fetch --prune upstream
  git reset upstream/gh-pages
  git add universe.json
  if git commit --message "$MESSAGE" --author "$AUTHOR" ; then
    git push --quiet upstream HEAD:gh-pages
  fi
}

function main() {
  setup && publish
}

main