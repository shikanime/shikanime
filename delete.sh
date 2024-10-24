#!/bin/bash

for i in $(seq 148 1000); do
  # Delete the branch locally
  git branch -D "origin/$i"

  # Push the deletion to the remote repository
  git push origin --delete "origin/$i"
done
