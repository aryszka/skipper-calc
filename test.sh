#! /bin/bash

set -e

skipper -debug-listener :9922 -access-log-disabled -max-loopbacks 1000000 -routes-file routes.eskip &
pid="$!"

cleanup() {
	kill -KILL "$pid"
}

trap cleanup SIGINT EXIT
sleep 1

# --

test() {
	op="$1"
	a="$2"
	b=
	e=
	r=
	if [ "$#" == 3 ]; then
		e="$3"
		r=$(curl -s localhost:9090/"$op/$a")
	else
		b="$3"
		e="$4"
		r=$(curl -s localhost:9090/"$op/$a/$b")
	fi

	if [ "$r" != "$e" ]; then
		echo invalid result for "$@": "$r"
		exit 1
	fi
}

test inc 0 1
test inc 1 2
test inc 2 3
test inc 8 9
test inc 9 10
test inc 42 43

test dec 1 0
test dec 2 1
test dec 3 2
test dec 9 8
test dec 10 9
test dec 43 42

test add 0 0 0
test add 0 1 1
test add 1 0 1
test add 1 1 2
test add 4 7 11
test add 7 4 11
test add 3 12 15
test add 12 3 15
test add 15 9 24
test add 15 18 33

test sub 0 0 0
test sub 0 1 0
test sub 1 0 1
test sub 1 1 0
test sub 4 7 0
test sub 7 4 3
test sub 3 12 0
test sub 12 3 9
test sub 15 9 6
test sub 15 18 0
test sub 18 15 3
test sub 24 15 9
test sub 33 15 18

test mul 0 0 0
test mul 0 1 0
test mul 1 0 0
test mul 1 1 1
test mul 3 2 6
test mul 2 3 6
test mul 4 7 28
test mul 7 4 28
test mul 3 12 36
test mul 12 3 36
test mul 15 9 135
test mul 15 18 270
test mul 18 15 270
test mul 24 15 360
test mul 33 15 495

test div 0 0 ERR
test div 0 1 0
test div 1 0 ERR
test div 1 1 1
test div 3 2 1
test div 2 3 0
test div 4 7 0
test div 7 4 1
test div 3 12 0
test div 12 3 4
test div 15 9 1
test div 15 18 0
test div 18 15 1
test div 24 15 1
test div 33 15 2
test div 729 27 27

echo ok
