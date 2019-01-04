#!/usr/bin/env sh

# abort on errors
set -e

# build
yarn build

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'
git config user.name "CircleCI"
git config user.email "circleci@lanternfish.cn"
git push -f https://github.com/lanternfish-research/lanterncharts.git master:gh-pages

cd -