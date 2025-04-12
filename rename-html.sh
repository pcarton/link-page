#! /bin/sh
DIR=$1
for file in $(find $DIR -type f -name "*.html"); do
  mv "$file" "${file%.html}.shtml"
done
