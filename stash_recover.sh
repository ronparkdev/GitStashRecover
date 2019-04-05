#!/bin/bash

commit_hashes=$(git fsck --no-reflog | awk '/dangling commit/ { print $3 }')

echo ">>>>>>>>> Begin <<<<<<<<<<"
echo ""

tmp_file=$(mktemp)

for commit_hash in $commit_hashes ; do
    # Writing commit log to temp file
    git show $commit_hash > $tmp_file || true

    # Filtering with 'WIP' and 'No' (it is prefix of stash commit message)
    commit_message_line=$(cat $tmp_file | grep -n Date: | head -1 | awk -F: '{ print $1 }')
    commit_message=$(cat $tmp_file | head -$(($commit_message_line + 2)) | tail -1 | xargs)
    commit_message_first_word=$(printf '%s\n' "$commit_message" | awk '{ print $1 }')

    if [ "$commit_message_first_word" != "WIP" ] && [ "$commit_message_first_word" != "No" ] ; then
        continue
    fi

    # Filtering within 30 days
    commit_rawdate=$(cat $tmp_file | grep Date: | head -1 | cut -d " " -f2-)
    commit_date=$(printf '%s\n' "$commit_rawdate" | awk '{printf "%04d-%02d-%02d\n", $5, (index("JanFebMarAprMayJunJulAugSepOctNovDec",$2)+2)/3 ,$3}')

    now_date=$(date +%F)
    diff_days=$(( ($(date -jf %Y-%m-%d $now_date +%s) - $(date -jf %Y-%m-%d $commit_date +%s)) / 86400 ))

    if [ $diff_days -gt 30 ] ; then
        continue
    fi

    # Extrating more infomations
    commit_author=$(cat $tmp_file | grep Author: | head -1 | awk '{print $2}')

    # Printing
    echo "   Date: $commit_date ($diff_days days ago)"
    echo " Author: $commit_author"
    echo "Message: $commit_message"
    echo "   Hash: $commit_hash"
    echo ""
done

# Removing temp file
rm $tmp_file

echo ">>>>>>>>> End <<<<<<<<<<"
