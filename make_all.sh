#!/bin/sh
cd ./ebin
rm -rf *.beam
cd ../src
erl -make


