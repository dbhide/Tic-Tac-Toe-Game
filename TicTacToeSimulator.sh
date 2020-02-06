
#!/bin/bash

echo "Welcome to Tic Tac Toe Game"

#CONSTANTS
ROWS=3
COLUMNS=3
X=1
PLAYER=1

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
function assignSymbol() {
	if [ $((RANDOM%2)) -eq $X ]
	then
		echo "Player Letter is : X"
	else
		echo "Player Letter is : O"
	fi
}

#To check who will play first
function checkTurn() {
	if [ $((RANDOM%2)) -eq $PLAYER ]
	then
		echo "Player will play first"
	else
		echo "Player will play first"
	fi
}

#To display board
function showBoard() {
	for ((i=1; i<=ROWS; i++))
	do
		for ((j=1; j<=COLUMNS; j++))
		do
			echo -e ""-" | \c"
		done
		echo
	done
}

resetBoard
assignSymbol
checkTurn
showBoard
