#!/bin/bash

ps aux | grep ${1} | grep -v grep | awk '{ print $2}' | xargs -I {} kill -9 {}


