docker images|grep v1.18|awk -F '[/ ]+' '{print "docker save "$1"/"$2":"$3,"-o",$2"-"$3".img"}'|bash
