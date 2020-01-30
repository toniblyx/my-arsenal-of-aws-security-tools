#!/bin/bash

# reads arsenal.csv with format name;username/repo;description
# and generate all badges and table format to paste on the README.md

while IFS=';' read NAME USERANDREPO DESC; do 
   echo "| **$NAME** | [https://github.com/$USERANDREPO](https://github.com/$USERANDREPO) | ${DESC} | [![stars](https://badgen.net/github/stars/$USERANDREPO)](https://badgen.net/github/stars/$USERANDREPO) | [![contributors](https://badgen.net/github/contributors/$USERANDREPO)](https://badgen.net/github/contributors/$USERANDREPO) [![watchers](https://badgen.net/github/watchers/$USERANDREPO)](https://badgen.net/github/watchers/$USERANDREPO) [![last-commit](https://badgen.net/github/last-commit/$USERANDREPO)](https://badgen.net/github/last-commit/$USERANDREPO) [![open-issues](https://badgen.net/github/open-issues/$USERANDREPO)](https://badgen.net/github/open-issues/$USERANDREPO) [![closed-issues](https://badgen.net/github/closed-issues/$USERANDREPO)](https://badgen.net/github/closed-issues/$USERANDREPO) |"
done < arsenal.csv
