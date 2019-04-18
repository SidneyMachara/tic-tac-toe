import '../models/player.dart';
class SinglePlayerLogicV1{

//  original game state moves, will be used to reset game state
  List<int> playerOneMoves;
  List<int> playerTwoMoves;

  //to make copy of current game sate
  List<int> playerOneMovesClone;
  List<int> playerTwoMovesClone;

  int activePlayerClone;


  SinglePlayerLogicV1( this.playerOneMoves, this.playerTwoMoves );



  int decideBestMove(){
    //make copy of current game sate
    resetGameState();
    int bestMove;

    int loses = 0;
    int recentLoses = 0;

    //try possible moves
    for(int x=0; x <= 8; x++){
      print("x = " + x.toString());
      print("losses = " + loses.toString());
      print("recentLosses = " + recentLoses.toString());
      print("**************************************************");
      if( playerOneMovesClone.contains(x) || playerTwoMovesClone.contains(x) ){
        continue;
      }else{

        //add the possibly best move to  player 2 moves
        if( recentLoses <= loses){
          print("changing bestMove" + recentLoses.toString() +","+ loses.toString());

          bestMove = x;
          print("new bM---> "+ x.toString());
          loses = recentLoses;
          print("changing bestMove" + recentLoses.toString() +","+ loses.toString());
          recentLoses = 0;
        }

        playerTwoMovesClone.add(bestMove);
        activePlayerClone = 1;


        int indexControl = 0;
        bool firstLoop = false; //firstLoopAfterIndexConttrolChange

        //play game to see where "bestMove" leads
        for(int j=indexControl; j <= 8; j++){
          print("current j" + j.toString());
          if( playerOneMovesClone.contains(j) || playerTwoMovesClone.contains(j) ){
            print("continue --> " + j.toString());
            if( firstLoop ){
              j = 0;
              firstLoop = false;
            }
            continue;
          }else{


            if( activePlayerClone == 1 ){
              playerOneMovesClone.add(j);
              //check if human won
              if( playerWon(playerOneMovesClone)){
                //reset game state
                resetGameState();
                playerTwoMovesClone.add(bestMove);


                activePlayerClone = 1;

                for(int u = 0; u <= 8; u++ ){ //make sure it doesnt start where it started before or on used cells

                  indexControl++;
                  if( isEmpty(indexControl)){
                    break;
                  }
                }



                j = indexControl;
                firstLoop = true;


                recentLoses++;

//                break;
              continue;
              }
              activePlayerClone = 2;

            }else if( activePlayerClone == 2){
              playerTwoMovesClone.add(j);
              activePlayerClone = 1;
            }

            if( firstLoop ){
              j = 0;
              firstLoop = false;
            }
          }

          if( j == 8 ){
            indexControl++;
            j = indexControl;
            firstLoop = true;
          }



          print("p1 --->" + playerOneMovesClone.toString());
          print("p2 --->" + playerTwoMovesClone.toString());
          print("-------------------------------------------" );
        }

        indexControl = 0;
        firstLoop = false;

        //reset game state
        resetGameState();

      }

    }


    return bestMove;

  }
























//  ----------------------------> helpers
  bool isEmpty(int btnId){

    if( playerOneMovesClone.contains(btnId) || playerTwoMovesClone.contains(btnId) ){
      return false;
    }
    return true;
  }

  void resetGameState(){
    playerOneMovesClone = copyArray(playerOneMoves);
    playerTwoMovesClone = copyArray(playerTwoMoves);
    activePlayerClone = 2;
  }


  List<int> copyArray(List<int> arrayToCopy){
    List<int> newArray =[];

    for(int i=0;i <= arrayToCopy.length -1; i++ ){
      newArray.add(arrayToCopy[i]);
    }
    return newArray;
  }

  bool playerWon(List<int> playerMoves){
    bool won = false;
//     first line horizontal
    if(playerMoves.contains(0) && playerMoves.contains(1) && playerMoves.contains(2)){
      return won = true;
    }
//     second line horizontal
    if(playerMoves.contains(3) && playerMoves.contains(4) && playerMoves.contains(5)){
      return won = true;
    }
//     third line horizontal
    if(playerMoves.contains(6) && playerMoves.contains(7) && playerMoves.contains(8)){
      return won = true;
    }
//     first line vertical
    if(playerMoves.contains(0) && playerMoves.contains(3) && playerMoves.contains(6)){
      return won = true;
    }
//      second line vertical
    if(playerMoves.contains(1) && playerMoves.contains(4) && playerMoves.contains(7)){
      return won = true;
    }
//      third line vertical
    if(playerMoves.contains(2) && playerMoves.contains(5) && playerMoves.contains(8)){
      return won = true;
    }
//     top 0 bottom 8 across
    if(playerMoves.contains(0) && playerMoves.contains(4) && playerMoves.contains(8)){
      return won = true;
    }
//    top 2 bottom 6 across
    if(playerMoves.contains(2) && playerMoves.contains(4) && playerMoves.contains(6)){
      return won = true;
    }


    return won;
  }



}