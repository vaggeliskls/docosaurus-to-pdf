#!/bin/sh
CMD="npx docs-to-pdf $DEFAULT_ARGS --initialDocURLs=\"$DOCS_URL\" --contentSelector=\"$CONTENT_SELECTOR\" --paginationSelector=\"$PAGINATION_SELECTOR\" --excludeSelectors=\"$EXCLUDE_SELECTOR\" --outputPDFFilename=\"$OUTPUT_PDF_FILENAME\""

if [ -n "$EXCLUDE_PATHS" ]; then
  CMD="$CMD --excludePaths=\"$EXCLUDE_PATHS\""
fi

if [ -n "$COVER_TITLE" ]; then
  CMD="$CMD --coverTitle=\"$COVER_TITLE\""
fi

# Execute the final command with all arguments
eval "$CMD" "$@"
