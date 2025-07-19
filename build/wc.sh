#!/bin/bash

usage() {
    echo "Usage: $0 <epub_file>"
    echo "Counts words within <p> tags in an EPUB file (case-insensitive)."
    exit 1
}

if [ -z "$1" ]; then
    usage
fi

EPUB_FILE="$1"

if [ ! -f "$EPUB_FILE" ]; then
    echo "Error: EPUB file '$EPUB_FILE' not found."
    exit 1
fi

TEMP_DIR=$(mktemp -d epub_wc_XXXXXX)
if [ $? -ne 0 ]; then
    echo "Error: Could not create temporary directory."
    exit 1
fi

unzip -q "$EPUB_FILE" -d "$TEMP_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to unzip '$EPUB_FILE'. Is it a valid EPUB file?"
    rm -rf "$TEMP_DIR"
    exit 1
fi

TOTAL_WORD_COUNT=0

TOTAL_WORD_COUNT=$(
    find "$TEMP_DIR" -type f \( -name "*.html" -o -name "*.xhtml" \) | while read -r file; do
        # Extract content between <P> and </P> tags (case-insensitive).
        # 1. 'sed -n '/<[Pp]>/,/<\/[Pp]>/p'': Prints lines from the start <P> or <p> tag
        #    to the end </P> or </p> tag. This captures the entire paragraph block.
        # 2. 'sed -e 's/<[Pp]>//gI' -e 's/<\/[Pp]>//gI'': Removes the literal <P>/<p> and </P>/</p> tags.
        #    Using 'gI' for global and case-insensitive replacement. If 'I' flag is not supported
        #    (e.g., on older BSD sed), the regex itself will handle case-insensitivity.
        # 3. 'sed -e 's/<[^>]*>//g'': Removes any other HTML/XML tags (e.g., <span>, <strong>, <br/>)
        #    that might be present *inside* the paragraph content.
        # 4. 'tr -s '[:space:]' '\n'': Replaces all sequences of whitespace (spaces, tabs, newlines)
        #    with a single newline character. This puts each "word" on its own line.
        # 5. 'grep -v '^$'': Removes any empty lines that might result from multiple spaces
        #    or tag removal, ensuring only actual words are counted.
        # 6. 'wc -l': Counts the number of lines, which now corresponds to the number of words.
        
        current_file_word_count=$(
            sed -n '/<[Pp]>/,/<\/[Pp]>/p' "$file" | \
            sed -e 's/<[Pp]>//gI' -e 's/<\/[Pp]>//gI' | \
            sed -e 's/<[^>]*>//g' | \
            tr -s '[:space:]' '\n' | \
            grep -v '^$' | \
            wc -l
        )
        
        echo "$current_file_word_count"
    done | awk '{s+=$1} END {print s}' # Sum all the word counts piped from the while loop
)

rm -rf "$TEMP_DIR"

# Now inject the word count into the frontmatter page (hardcoded)

HTML_FILE="book/OEBPS/text/01_frontmatter.xhtml"

sed -i '' "s|<p>Word count: .*</p>|<p>Word count: $TOTAL_WORD_COUNT</p>|g" "$HTML_FILE"

echo "Word count updated in $HTML_FILE: $TOTAL_WORD_COUNT"
