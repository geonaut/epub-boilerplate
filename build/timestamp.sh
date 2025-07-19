#!/bin/bash

NEW_TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

HTML_FILE="book/OEBPS/text/01_frontmatter.xhtml"

sed -i '' "s|<p>Generated at: .*</p>|<p>Generated at: $NEW_TIMESTAMP</p>|g" "$HTML_FILE"

echo "Timestamp updated in $HTML_FILE: $NEW_TIMESTAMP"