#!/usr/bin/env sh

cd slides
node_modules/@marp-team/marp-cli/marp-cli.js index.md -o ../slides.pdf --html true --allow-local-files
node_modules/@marp-team/marp-cli/marp-cli.js index.md -o ../slides.txt --html true --notes true --allow-local-files
cd ../
