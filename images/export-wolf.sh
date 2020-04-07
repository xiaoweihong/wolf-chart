#!/bin/bash

docker images|grep wolf|awk -F '[/ ]+' '{print "docker save "$1"/"$2"/"$3":"$4,"-o",$3"-"$4".img"}'|bash
