#!/bin/bash

docker images|grep wolf|awk -F '[/ ]+' '{print "docker push "$1"/"$2"/"$3":"$4}'|bash
