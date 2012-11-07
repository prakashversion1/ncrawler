#!/bin/bash

mkdir index -p
cd index

#must change the index to follow the next page link
for i in `seq 1 95`; do
    wget -c "http://www.aljazeera.com/Services/IncludePart/?T=15&Id=201082874848848938&P=$i&V=2"
done

