runtestcase() {
	#run "$1" bin/ouija "$2" | strings -e S
	run "$1" ./testone.sh "$2"
}
