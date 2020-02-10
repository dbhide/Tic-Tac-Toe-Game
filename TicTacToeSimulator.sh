#!/bin/bash -x

echo "Welcome to Tic Tac Toe Game"

#CONSTANTS
ROWS=3
COLUMNS=3
MOVES=9
PLAYER=0

#Variables
counter=1
flag=0

declare -A board

#To reset the board
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
		playerLetter=$"X"
		computerLetter=$"O"
	else
		playerLetter=$"O"
		computerLetter=$"X"
	fi
}

#To check who will play first
function checkTurn() {
	if [ $((RANDOM%2)) -eq $PLAYER ]
	then
		flag=0
		echo "Player will play First !!"
	else
		flag=1
		echo "Computer will play First !! "
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

#To check valid cells to place symbol
function validMove() {
	row=$1
	column=$2
	letter=$3
	if [[ ${board[$row,$column]} == $"-" ]]
	then
		board[$row,$column]=$letter
		showBoard
	else
		echo "Invalid Cell"
		game
	fi
}

resetBoard
assignSymbol
checkTurn
showBoard

#To check posiible winning conditions
function winningConditions() {
	firstDiagonalCount=0
	secondDiagonalCount=0
	for(( i=0; i<$ROWS; i++))
	do
		rowCount=0
		columnCount=0
		for(( j=0; j<$COLUMNS; j++))
		do
			if [[ ${board[$i,$j]} == $1 ]]
			then
				rowCount=$((rowCount+1))
			fi
			if [[ ${board[$j,$i]} == $1 ]]
			then
				columnCount=$((columnCount+1))
			fi
			if [[ $(( i+j )) -eq $(( ROWS-1 )) && ${board[$i,$j]} == $1 ]]
			then
				secondDiagonalCount=$((secondDiagonalCount+1))
			fi
			if [[ $i -eq $j && ${board[$i,$j]} == $1 ]]
			then
				firstDiagonalCount=$((firstDiagonalCount+1))
			fi
			if [[ $rowCount -eq $ROWS || $columnCount -eq $COLUMNS || $firstDiagonalCount -eq 3 || $secondDiagonalCount -eq 3 ]]
			then
				echo $1 "Wins"
				exit
			fi
		done
	done
}

#Main
function game() {
while [ $counter -ne $MOVES ]
do
	#read -p "Enter row and column number - " rowValue columnValue
	if [ $flag -eq 0 ]
	then
		echo "Player's Turn"
		read -p "Enter row and column number - " rowValue columnValue
		validMove $rowValue $columnValue $playerLetter
		board[$rowValue,$columnValue]=$playerLetter
		winningConditions $playerLetter
		((counter++))
		flag=1
	else
		echo "Computer's Turn"
		read -p "Enter row and column number - " rowValue columnValue
		validMove $rowValue $columnValue $computerLetter
		board[$rowValue,$columnValue]=$computerLetter
		winningConditions $computerLetter
		((counter++))
		flag=0
	fi
done
}
game
