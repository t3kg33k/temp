#!/usr/bin/env bash

# Usage: ./copy_non_duplicates.sh <source1> <source2> <dest>

SOURCE1="$1"
SOURCE2="$2"
DEST="$3"

# Exit on errors
set -e

# Validate inputs
if [[ -z "$SOURCE1" || -z "$SOURCE2" || -z "$DEST" ]]; then
    echo "Usage: $0 <source1> <source2> <dest>"
    exit 1
fi

if [[ ! -d "$SOURCE1" || ! -d "$SOURCE2" ]]; then
    echo "Both source directories must exist."
    exit 1
fi

mkdir -p "$DEST"

echo "Indexing files in $SOURCE2 ..."
declare -A CHECKSUMS

# Build a checksum map from SOURCE2
while IFS= read -r -d '' file; do
    sum=$(sha256sum "$file" | awk '{print $1}')
    CHECKSUMS["$sum"]=1
done < <(find "$SOURCE2" -type f -print0)

echo "Checking files in $SOURCE1 ..."
while IFS= read -r -d '' file; do
    sum=$(sha256sum "$file" | awk '{print $1}')

    if [[ -z "${CHECKSUMS[$sum]}" ]]; then
        echo "New file found: $file"
        cp -v "$file" "$DEST/"
    fi
done < <(find "$SOURCE1" -type f -print0)

echo "Done."
