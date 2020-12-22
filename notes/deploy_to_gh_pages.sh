#!/bin/bash

cd ..
git add .
git subtree push --prefix notes/out origin gh-pages
