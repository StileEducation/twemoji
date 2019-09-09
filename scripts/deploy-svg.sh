#!/usr/bin/env bash

function cleanup {
    git checkout $1
    if [ $2 = true ]; then
        git stash pop
    fi
}

set -eux

CHANGES=$(git diff-index --quiet HEAD -- && echo "false" || echo "true")

set -o pipefail

ROOT=$(
  cd $(dirname $0)/..
  /bin/pwd
)
DIST="$ROOT/dist/"
START_BRANCH=$(git rev-parse --abbrev-ref HEAD)
PUBLISH_BRANCH=$1
VERSION=$(jq -r '.version' package.json)
DEPS=$(jq -r '.dependencies' package.json)

git fetch --all

trap "cleanup $START_BRANCH $CHANGES" EXIT

[ $CHANGES =  true ] && git stash
git checkout $PUBLISH_BRANCH

git pull origin $PUBLISH_BRANCH

cp -r $DIST/*.js  $DIST/*svg* "$ROOT/2"
TMP=(mktemp)
jq ".version = $VERSION | .dependencies = $DEPS" package.json > $TMP
mv $TMP package.json

git add "$ROOT/2" package.json yarn.lock

git commit -q -m "Publish v$VERSION"
git push origin $PUBLISH_BRANCH
