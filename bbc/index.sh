#!/bin/bash

#the index should fresh so re-download everything
rm -fr index
mkdir -p index
wget -c http://www.bbc.co.uk/blogs/theeditors/archives.html -O index/archives.html
