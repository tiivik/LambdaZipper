#!/bin/bash
mkdir temp
python3 -m pip install $1 -t temp
rm -f /package/$1.zip

cd temp
zip -r /package/$1.zip *