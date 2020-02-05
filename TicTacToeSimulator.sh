#!/bin/bash -x

echo "Welcome to Tic Tac Toe Game"

#CONSTANTS
ROWS=3
COLUMNS=3

declare -A board

#To rest the board
function resetBoard() {
	for ((i=0; i<ROWS; i++))
	do
		for((j=0; j<COLUMNS; j++))
		do
			board[$i,$j]="-"
		done
	done
}

resetBoard
