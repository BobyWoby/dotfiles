#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null
then
    pkill "hyprsunset"
else
    exec "hyprsunset"
fi

