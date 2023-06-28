#!/bin/bash

# Clone GitHub Pages repository
git config --global user.email "luizleno15@gmail.com"
git config --global user.name "luislenosilva15"
git clone --branch=gh-pages git@github.com:luislenosilva15/storybook.git gh-pages

# Loop through Storybook directories
for dir in storybooks/*; do
  if [[ -d $dir ]]; then
    # Extract Storybook name from directory
    storybook_name=$(basename "$dir")

    # Build Storybook
    cd "$dir"
    npm install
    npm run build-storybook

    # Archive Storybook
    mkdir -p "../storybook-archives/$storybook_name"
    cp -R storybook/ "../storybook-archives/$storybook_name"

    # Update GitHub Pages
    cd "../gh-pages"
    cp -R "../storybook-archives/$storybook_name/." "$storybook_name"
    git add .
    git commit -m "Update GitHub Pages - $storybook_name"
    git push origin gh-pages

    # Go back to root directory
    cd ..
  fi
done