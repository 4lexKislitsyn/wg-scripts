#!/bin/bash
sh conf.sh $1 | qrencode -t ansiutf8
