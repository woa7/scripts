:
set -vx
if [[ $2 == "" ]]; then
	echo "Usage: $0 name command";
	exit 1;
fi
name=$1
shift
command=$@
path="/var/log";
config="logfile ${path}/${name}.log
logfile flush 1
log on
logtstamp after 1
logtstamp string \"[ %t: %Y-%m-%d %c:%s ]\012\"
logtstamp on";
echo "$config" > /tmp/screenlog.conf
##screen -c /tmp/screenlog.conf -dmSL "$name" -X "$command"
#screen -c /tmp/screenlog.conf -dm -L -S "$name" ${command}
#screen_cmd='screen -L -S "${name}" -d -m /bin/bash --login -c'
#screen_cmd='screen -L -S '${name}' -d -m /bin/bash --login -c'
screen_cmd='screen -c /tmp/screenlog.conf -L -S '${name}' -d -m /bin/bash --login -c'
$screen_cmd "${command}"
echo "do a"
echo "tail -f ${path}/${name}.log"
rm /tmp/screenlog.conf
