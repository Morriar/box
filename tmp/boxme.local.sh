
# This file is sourced by the boxme command.
# Use-it to override specific functions.

runtestcase() {
	run "$1" bin/hello $(cat "$2")
}

