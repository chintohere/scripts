#!/bin/sh

#Initialize where all the sources will be exported to
sources="sources"

if [ -n "$1" ]; then
        sources=$1
fi

echo "Code will be exported to '"$sources"'."

#Read releases to export
input=export.releases
echo "Reading "$input

#Repository tags base on SVN
repo_tags="http://integ:90/repos/RASP/tags/GA/"

#Start processing
while read line
do
        release="$repo_tags$line"
        if [ -n "$line" ]; then
                dest="$sources/$line"
                echo "Exporting : "$release" to dir: "$dest"..."
                svn  export -q $release $dest
                echo "Done."
        fi
done < "$input"
echo "Export complete!"

#Tar and zip them sources up
echo "Packaging "$sources"..."
tar czf "$sources.tar.gz" $sources
echo "Done."
                                                   