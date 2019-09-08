Twemoji with SVGs by Stile Education
====================================

# Updating from upstream
You too can update this repo from [upstream](github.com/twitter/twemoji) by following this proceedure.

Clone this repo
```
git clone git@github.com:StileEducation/twemoji.git
```
Add upstream as a remote.
```
git remote add upstream https://github.com/twitter/twemoji.git
git fetch upstream
```
Switch to the `export_svg` branch and merge master
```
git checkout export_svg
git merge upstream/master
```
Build and deploy
```
yarn install
yarn build
yarn deploy-svg
```
This will update the `svg` branch with the latest code and svg assets.
A dependency in `package.json` of the form
```
"twemoji": "github:StileEducation/twemoji#svg"
```
will then pull from this repo during a yarn install.

Make sure you clean up before building again
```
git clean -idx
```
and check the output is sane before cleaning.

# Files
This branch hosts the built assets for Twemoji, and the folder structure can be summarized as follows:

| Top level     | Second | Files               | Description                                                                                | Version     |
| ------------- | ------ | ------------------- | ------------------------------------------------------------------------------------------ | ----------- |
| .             |        | \*.md, *.json, .\*  | meta data                                                                                  | 1.0, 2.2    |
| 2/            |        | twemoji*.js         | Framework js assets                                                                        | 2.2         |
| 2/            | test/  | index.html, test.js | Tests                                                                                      | 2.2         |
| 2/            | 72x72/ | `{codepoint}`.png   | large PNGs                                                                                 | 2.2         |
| 2/            | svg/   | `{codepoint}`.svg   | SVGs                                                                                       | 2.2         |
