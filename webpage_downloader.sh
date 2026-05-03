#!/bin/bash

# webpage_downloader.sh
# Downloads a webpage using curl and saves it locally

set -euo pipefail  # Exit on error, undefined vars, and pipe failures

# Default output filename
DEFAULT_OUTPUT="downloaded_page.html"

# Parse arguments
URL=""
OUTPUT_FILE="$DEFAULT_OUTPUT"

usage() {
    echo "Usage: $0 -u <URL> [-o <output_file>]" >&2
    echo "  -u  URL to download (required)" >&2
    echo "  -o  Output filename (optional, defaults to '$DEFAULT_OUTPUT')" >&2
    exit 1
}

while getopts "u:o:h" opt; do
    case "$opt" in
        u) URL="$OPTARG" ;;
        o) OUTPUT_FILE="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Validate input
if [[ -z "$URL" ]]; then
    echo "Error: URL is required." >&2
    usage
fi

# Ensure the URL uses a scheme (curl may not default to https)
if [[ "$URL" != http://* && "$URL" != https://* ]]; then
    URL="https://$URL"
fi

# Download the page
echo "Downloading '$URL'..."
curl --silent --show-error --location --output "$OUTPUT_FILE" "$URL"

echo "Saved to: $OUTPUT_FILE"
