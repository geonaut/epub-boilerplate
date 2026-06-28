#!/bin/bash
#
# Counts words inside <p> tags and injects into the frontmatter page.

usage() {
    echo "Usage: $0 [text_dir]"
    echo "Counts words within <p> tags in *chapter*.xhtml under text_dir"
    echo "(default: book/OEBPS/text) and writes the total into 01_frontmatter.xhtml."
    exit 1
}

[ "$1" = "-h" ] || [ "$1" = "--help" ] && usage

TEXT_DIR="${1:-book/OEBPS/text}"
FRONTMATTER="$TEXT_DIR/01_frontmatter.xhtml"

if [ ! -d "$TEXT_DIR" ]; then
    echo "Error: text directory '$TEXT_DIR' not found." >&2
    exit 1
fi


count_words_in_file() {
    sed -n '/<[Pp]>/,/<\/[Pp]>/p' "$1" \
        | sed -e 's/<[Pp]>//gI' -e 's/<\/[Pp]>//gI' \
        | sed -e 's/<[^>]*>//g' \
        | tr -s '[:space:]' '\n' \
        | grep -v '^$' \
        | wc -l
}

TOTAL_WORD_COUNT=0
for file in "$TEXT_DIR"/*chapter*.xhtml; do
    [ -e "$file" ] || continue   # no chapters matched the glob
    n=$(count_words_in_file "$file")
    TOTAL_WORD_COUNT=$((TOTAL_WORD_COUNT + n))
done

if [ ! -f "$FRONTMATTER" ]; then
    echo "Error: frontmatter '$FRONTMATTER' not found; cannot inject word count." >&2
    exit 1
fi

sed -i '' "s|<p>Word count: .*</p>|<p>Word count: $TOTAL_WORD_COUNT</p>|g" "$FRONTMATTER"

echo "Word count updated in $FRONTMATTER: $TOTAL_WORD_COUNT"
