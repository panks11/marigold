#!/usr/bin/env bash
while getopts a:n:u:d: flag
do
    case "${flag}" in
        a) author=${OPTARG};;
        n) name=${OPTARG};;
        u) urlname=${OPTARG};;
        d) description=${OPTARG};;
    esac
done

echo "Author: $author";
echo "Project Name: $name";
echo "Project URL name: $urlname";
echo "Project Description: $description";

echo "Renaming project..."

original_author="panks11"
original_name="marigold"
original_urlname="https://github.com/jeremywurbs/marigold/"
original_description="Awesome marigold created by panks11"

for filename in $(git ls-files)
do
    if [[ $filename == *"workflows"* ]]; then
        continue
    fi
    sed -i "s@$original_author@$author@g" $filename
    sed -i "s@${original_name^}@${name^}@g" $filename
    sed -i "s@${original_name^^}@${name^^}@g" $filename
    sed -i "s@$original_name@$name@g" $filename
    sed -i "s@$original_urlname@$urlname@g" $filename
    sed -i "s@$original_description@$description@g" $filename
    echo "Renamed $filename"
done

mv marigold $name
mv _README.md README.md -f

# This command runs only once on GHA!
rm -rf .github/template.yml
