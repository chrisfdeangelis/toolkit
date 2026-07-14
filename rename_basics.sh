#!/bin/bash

find . -type f -name "basics.md" | while read -r file; do
    dir="$(dirname "$file")"
    mv "$file" "$dir/README.md"
    echo "Renamed: $file -> $dir/README.md"
done

echo "Done!"
