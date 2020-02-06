#!/bin/bash

echo "Welcome to Tic Tac Toe Game"

#CONSTANTS
ROWS=3
COLUMNS=3
X=1
MOVES=9

#Variables
counter=1

declare -A board

#To rest the board
function resetBoard() {
	for ((i=0; i<$ROWS; i++))
	do
		for((j=0; j<$COLUMNS; j++))
		do
			board[$i,$j]="-"
		done
	done
}

#To assign letter to a player
function assignSymbol() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		playerLetter=X
	else
		playerLetter=O
	fi
}

#To check who will play first
function checkTurn() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		player=true
	else
		player=true
	fi
}

#To display board
function showBoard() {
	for ((i=0; i<$ROWS; i++))
	do
		for ((j=0; j<$COLUMNS; j++))
		do
			echo -e "${board[$i,$j]} | \c"
		done
		echo
	done
}

function validMove() {
	row=$1
	column=$2
	letter=$3
	if [[ ${board[$row,$column]} == "-" ]]
	then
		board[$row,$column]=$letter
		((counter++))
	else
		echo "Cell already occupied...Try another cell !!"
	fi
}

resetBoard
assignSymbol
checkTurn
showBoard

while [ $counter -ne $MOVES ]
do
	if [[ $player == true ]]
	then
		read -p "Enter row and column number - " rowValue columnValue
		validMove $rowValue $columnValue $playerLetter
	fi
	showBoard
done
