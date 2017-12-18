#!/bin/bash

SAMPLE() {
	echo "Hello , Line 1 from function"
	return 2
	echo "Hello, Line2 from function"
}


SAMPLE
echo "Exit Status = $?"