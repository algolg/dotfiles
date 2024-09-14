#!/bin/bash

prefix=""
extension=" --clipboard-only "

if [[ $1 == "-r" ]] || [[ $2 == "-r" ]]; then
    extension="${extension} -m region"
else
    extension="${extension} -m screen"
fi
if [[ $1 == "-d" ]] || [[ $2 == "-d" ]]; then
    prefix="sleep 3 && "
fi

eval "${prefix}hyprshot${extension}"

