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

#To assign letter to a player
function symbolAndToss() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		echo "Player Symbol = X"
		playerTurn=true
	else
		echo "Player Symbol = O"
		playerTurn=true
	fi
}

resetBoard
symbolAndToss

