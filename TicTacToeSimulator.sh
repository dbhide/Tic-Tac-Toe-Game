#!/bin/bash -x

echo "Welcome to Tic Tac Toe Game"

#CONSTANTS
ROWS=3
COLUMNS=3
MOVES=9
PLAYER=0

#Variables
moveCounter=1
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
		echo "Computer will play First !!"
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
	else
		echo "Invalid Cell"
		game
	fi
}

#To check tie condition
function checkTie() {
	if [[ $moveCounter -gt $MOVES ]]
	then
		echo "It's a Tie !!"
		exit
	fi
}

function initialize(){
	x=0
	y=0
	counter1=0
	counter2=0
}

function insertSymbol(){
	local p=$1
	local q=$2
	local symbol=$3
	board[$p,$q]=$symbol
	flag1=0
	flag2=1
}

function setSymbol(){
	local p=$1
	local q=$2
	local matchSymbol=$3
	if [[ ${board[$p,$q]} == $matchSymbol ]]
	then
		((counter1++))
	fi
	if [[ ${board[$p,$q]} == $"-" ]]
	then
		x=$p
		y=$q
		((counter2++))
	fi
}

#To win and block rows
function checkRow(){
	local putSymbol=$2
	local checkSymbol=$1
	if [ $flag2 -eq 0 ]
	then
		for (( i=0; i<$ROWS; i++ ))
		do
			initialize
			for (( j=0; j<$COLUMNS; j++ ))
			do
				setSymbol $i $j $checkSymbol
			done
			if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
			then
				insertSymbol $x $y $putSymbol
			fi
		done
	fi
}

#To win and block columns
function checkColumn(){
	local putSymbol=$2
 	local checkSymbol=$1
	if [ $flag2 -eq 0 ]
	then
		for (( i=0; i<$ROWS; i++ ))
		do
			initialize
			for (( j=0; j<$COLUMNS; j++ ))
			do
				setSymbol $j $i $checkSymbol
			done
			if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
			then
				insertSymbol $x $y $putSymbol
			fi
		done
	fi
}

#To win and block first diagonal
function checkFirstDigonal(){
	local putSymbol=$2
	local checkSymbol=$1
	if [ $flag2 -eq 0 ]
	then
		initialize
		for (( i=0; i<$ROWS; i++ ))
		do
			for (( j=0; j<$COLUMNS; j++ ))
			do
				if [ $i -eq $j ]
				then
					setSymbol $i $j $checkSymbol
				fi
			done
			if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
			then
				insertSymbol $x $y $putSymbol
			fi
		done
	fi
}

#To win and block second Diagonal
function checkSecondDigonal(){
	local putSymbol=$2
	local checkSymbol=$1
	if [ $flag2 -eq 0 ]
	then
		initialize
		for (( i=0; i<$ROWS; i++ ))
		do
			for (( j=$((2-$i)); j<$COLUMNS; j++ ))
			do
				setSymbol $i $j $checkSymbol
				break;
			done
			if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
			then
				insertSymbol $x $y $putSymbol
			fi
		done
	fi
}

function checkBoard(){
	local viewSymbol=$1
	local placeSymbol=$2
	flag1=1
	flag2=0
	checkRow $viewSymbol $placeSymbol
	checkColumn $viewSymbol $placeSymbol
	checkFirstDigonal $viewSymbol $placeSymbol
	checkSecondDigonal $viewSymbol $placeSymbol
}

#To check available corners
function checkCorners() {
	flag1=1
	local sign=$1
	for(( i=0; i<ROWS; i=$(($i+2)) ))
	do
		for(( j=0; j<COLUMNS; j=$(($j+2)) ))
		do
			if [[ ${board[$i,$j]} == $"-" ]]
			then
				board[$i,$j]=$sign
				flag1=0
			return
			fi
		done
done
}

#To check centre position
function checkCentre() {
	flag1=1
	local sign=$1
	if [[ ${board[1,1]} == $"-"	]]
	then
		board[1,1]=$sign
		flag1=0
		return
	fi
}

#To check available sides
function checkSides() {
	flag1=1
	local sign=$1
	for (( i=0; i<$(($ROWS-1)); i++ ))
	do
		for (( j=0; j<$(($COLUMNS-1)); j++ ))
		do
			if [[ $(($j%2)) -eq 0 ]]
			then
				if [[ ${board[$i,$(($i+1))]} == $"-" ]]
				then
					board[$i,$(($i+1))]=$sign
					flag1=0
					return
				fi
			else
				if [[ ${board[$(($i+1)),$i]} == $"-" ]]
				then
					board[$(($i+1)),$i]=$sign
					flag1=0
					return
				fi
			fi
		done
	done
}

resetBoard
assignSymbol
checkTurn
showBoard

#To check winner
function winner() {
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
while [ $moveCounter -lt $(($MOVES+1)) ]
do
	if [ $flag -eq 0 ]
	then
		echo "Player's Turn"
		read -p "Enter Row and Column number - " rowValue columnValue
		validMove $rowValue $columnValue $playerLetter
		board[$rowValue,$columnValue]=$playerLetter
		showBoard
		winner $playerLetter
		((moveCounter++))
		checkTie
		flag=1
	else
		flag1=1
		echo "Computer's Turn"
		if [[ $flag1 -eq 1 ]]
		then
			checkBoard $computerLetter $computerLetter
		fi
		if [[ $flag1 -eq 1 ]]
		then
			checkBoard $playerLetter $computerLetter
		fi
		if [[ $flag1 -eq 1 ]]
		then
			checkCorners $computerLetter
		fi
		if [[ $flag1 -eq 1 ]]
		then
			checkCentre $computerLetter
		fi
		if [[ $flag1 -eq 1 ]]
		then
			checkSides $computerLetter
		fi
 		showBoard
		winner $computerLetter
		((moveCounter++))
		checkTie
		flag=0
	fi
done
}
game
