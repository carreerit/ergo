#!/bin/bash


SAMPLE() {
	echo "######## IN FUNCTIONS ########"
	echo "Script Name = $0 "
	echo "First argument = $1"
	echo "Second argument = $2"
	echo "All arguments = $*"
	echo "Number of arguments = $#"
}

	echo "######## MAIN PROGRAM ########"
	echo "Script Name = $0 "
	echo "First argument = $1"
	echo "Second argument = $2"
	echo "All arguments = $*"
	echo "Number of arguments = $#"

	SAMPLE 30 40