#!/usr/bin/env bash

set -e

DOC_FOLDER="docs"
SITE_FOLDER="website"
BUNDLE_REPORT_FOLDER="bundle-report"

MAIN_BRANCH="master"
TEST_BRANCH="test"
UPSTREAM="https://$GITHUB_TOKEN@github.com/$TRAVIS_REPO_SLUG.git"
AUTHOR="$USER <>"

if [ "$TRAVIS_PULL_REQUEST" != "false" ];then
  echo "Not republishing : on pull request"
  exit 0
fi

if [ "$TRAVIS_BRANCH" != "$MAIN_BRANCH" && "$TRAVIS_BRANCH" != "$TEST_BRANCH" ];then
  echo "Not republishing : not on branch $MAIN_BRANCH"
  exit 0
fi

if [ "$TRAVIS_BRANCH" == "$MAIN_BRANCH" ]; then
  MESSAGE="Republishing universe for revision $TRAVIS_COMMIT: $TRAVIS_COMMIT_MESSAGE"
  UNIVERSE_JSON="universe.json"
fi

if [ "$TRAVIS_BRANCH" == "$TEST_BRANCH" ]; then
  MESSAGE="Republishing test universe for revision $TRAVIS_COMMIT: $TRAVIS_COMMIT_MESSAGE"
  UNIVERSE_JSON="universe-test.json"
fi


function setup() {
    ls target
}

function publish() {

  mv target/universe.json $UNIVERSE_JSON

  git init
  git remote add upstream "$UPSTREAM"
  git fetch --prune upstream
  git reset upstream/gh-pages
  git add $UNIVERSE_JSON
  if git commit --message "$MESSAGE" --author "$AUTHOR" ; then
    git push --quiet upstream HEAD:gh-pages
  fi
}

function main() {
  setup && publish
}

main
