#!/bin/bash

# Initialize the command array
CMD=("docs-to-pdf")

# Add optional arguments if they are defined
[ -n "$DOCS_URL" ] && CMD+=("--initialDocURLs=\"$DOCS_URL\"")
[ -n "$OUTPUT_PDF_FILENAME" ] && CMD+=("--outputPDFFilename=\"$OUTPUT_PDF_FILENAME\"")
[ -n "$PUPPETEER_ARGS" ] && CMD+=("--puppeteerArgs=\"$PUPPETEER_ARGS\"")
[ -n "$EXCLUDE_URLS" ] && CMD+=("--excludeURLs=\"$EXCLUDE_URLS\"")
[ -n "$EXLUDE_PATHS" ] && CMD+=("--excludePaths=\"$EXLUDE_PATHS\"")
[ -n "$COVER_TITLE" ] && CMD+=("--coverTitle=\"$COVER_TITLE\"")
[ -n "$CONTENT_SELECTOR" ] && CMD+=("--contentSelector=\"$CONTENT_SELECTOR\"")
[ -n "$PAGINATION_SELECTOR" ] && CMD+=("--paginationSelector=\"$PAGINATION_SELECTOR\"")
[ -n "$EXCLUDE_SELECTOR" ] && CMD+=("--excludeSelectors=\"$EXCLUDE_SELECTOR\"")
[ -n "$EXTRA_ARGS" ] && CMD+=("$EXTRA_ARGS")

# Print the full command for debugging
echo "Executing command: ${CMD[@]} $@"

# Execute the command with additional arguments passed to the script
eval "${CMD[@]}" "$@"