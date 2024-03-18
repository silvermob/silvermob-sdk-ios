#!/bin/bash

# Function to rename occurrences of a string in file contents, file names, and folder names
rename_occurrences() {
    local old_string=$1
    local new_string=$2

    # Set LC_ALL to C for ASCII processing
    export LC_ALL=C

    # Exclude .git directory and the script itself from file search, then rename $old_string to $new_string inside file contents
    find . -type f ! -path '*/.git/*' ! -name 'rename.sh' -exec sed -i '' "s/${old_string}/${new_string}/g" {} +

    # Exclude .git directory and the script itself from directory and file names search, then rename files and directories containing $old_string in their names
    # Starting from the deepest files and directories to avoid issues with moved paths
    find . -depth ! -path '*/.git/*' ! -path './rename.sh' -name "*${old_string}*" | while IFS= read -r file ; do
        # Using 'dirname' and 'basename' to construct the new path
        mv "$file" "$(dirname "$file")/$(basename "$file" | sed "s/${old_string}/${new_string}/g")"
    done
}

# Your rename operations
rename_occurrences "PrebidMobile" "SilverMobSdk"
rename_occurrences "PrebidMAXMediationAdapter" "SilverMobMAXMediationAdapter"

echo "Renaming complete."
