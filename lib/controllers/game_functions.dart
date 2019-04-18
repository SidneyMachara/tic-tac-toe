////---------------------------singlePlayer
//if( singlePlayer ){
//List<int> playerOneMovesClone = copyArray(playerOne.playerMoves);
//List<int> playerTwoMovesClone = playerTwo.playerMoves.isNotEmpty ? copyArray(playerTwo.playerMoves) : [];
//Player activePlayerClone = playerTwo;
//int bestMove;
//
//for(int x=0; x <= 8; x++){
//
//if( playerOneMovesClone.contains(x) || playerTwoMovesClone.contains(x)){
//continue;
//}else{
//
//bestMove = x;
//playerTwoMovesClone.add(x);
//print(playerTwoMovesClone);
//print(playerTwo.playerMoves);
//activePlayerClone = playerOne;
//
//for(int t=0; t <= 8; t++) {
//if (playerOneMovesClone.contains(t) || playerTwoMovesClone.contains(t)) {
//continue;
//}else{
//activePlayerClone.playerMoves.add(t);
//
//if( activePlayerClone.playerHandle == "playerOne"){
//playerOneMovesClone.add(t);
//activePlayerClone = playerTwo;
//}
//else if( activePlayerClone.playerHandle == "playerTwo"){
//playerTwoMovesClone.add(t);
//if( playerWon(playerTwoMovesClone)){
//
//playerOneMovesClone = copyArray(playerOne.playerMoves);
//playerTwoMovesClone = playerTwo.playerMoves.isNotEmpty ? copyArray(playerTwo.playerMoves) : [];
//activePlayerClone = playerTwo;
//
//break;
//}
//activePlayerClone = playerOne;
//}
//}
//}
////--
//}
//}
//buttonsList[bestMove].text = "0";
//buttonsList[bestMove].bg = Colors.black;
//
//playerTwo.playerMoves.add(buttonsList[bestMove].id); //add the btn to playerTwo's collection
//playerWon(playerTwo.playerMoves) ? print("two wins"): print("");
//
//activePlayer = playerOne;
//buttonsList[bestMove].enabled = false;
//
//}
////-----------------------------singlePlayer
