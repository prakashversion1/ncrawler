#!/bin/bash

for i in index/*; do
    sed -n '/<div class=\"h89\">/,/<\/table>/p' "$i"| sed 's/\r//g; s/^ *//' | sed 's/.*<a href="\(.*html\)"[^>]*>/\n\1\n/; s/<[^>]*>//g; /^$/d'
done
