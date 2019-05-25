#!/bin/bash

myname=`basename $0`
mypath=$(cd `dirname $0` && pwd)

cd $mypath

usage() {
	cat <<EOF
usage: $mypath [-r number of replicas]
EOF
}

opt_replica=0
while getopts hr: c
do
    case $c in
        r)  opt_replica=$OPTARG
            ;;
        h)  
			usage
			exit 0
            ;;
        \?) 
			usage
			exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

myaddr=`getent ahosts $HOSTNAME | grep STREAM | awk '{print $1}'`
echo "IP-Addr: $myaddr" 1>&2

echo_nodes() {
	for i in node-*
	do
		local port=`echo $i | sed -e 's/^node-//'`
		echo "$myaddr:$port"
	done
}

# clusterize
arg_replica=""
if [[ $opt_replica -gt 0 ]]
then
	arg_replicas="--cluster-replicas $opt_replica"
fi

yes yes | redis-cli --cluster create $arg_replicas `echo_nodes`

