import 'package:flutter/material.dart';
import '../models/game_btn.dart';
import '../models/player.dart';
import '../controllers/singel_player_logic_v1.dart';

class GamePage extends StatefulWidget{
  @override
  GamePageState createState() => new GamePageState();
}

class GamePageState extends State<GamePage>{
  List<GameBtn> buttonsList;
  Player playerOne = new Player(playerHandle: "playerOne");
  Player playerTwo = new Player(playerHandle: "playerTwo");

  Player activePlayer;
  bool singlePlayer = true;
  bool gameOver = false;


  @override
  void initState() {
    super.initState();
    buttonsList = generateNewGameBtns();
    activePlayer = playerOne;
  }



  void play(int gameBtnId){

    if( gameOver ){
      return;
    }

    setState((){

      if( activePlayer.playerHandle == "playerOne" ){

        buttonsList[gameBtnId].text = "X";
        buttonsList[gameBtnId].bg = Colors.red;

        playerOne.playerMoves.add(buttonsList[gameBtnId].id); //add the btn to playerOne's collection
        if( playerWon(playerOne.playerMoves) ){
          print("one wins");
          gameOver = true;
        }


        activePlayer = playerTwo;
        //disable GameBtn
        buttonsList[gameBtnId].enabled = false;

        //---------------------------singlePlayer
        if( singlePlayer ){

          SinglePlayerLogicV1 splV1 = new SinglePlayerLogicV1(playerOne.playerMoves, playerTwo.playerMoves);
          int bestMove = splV1.decideBestMove();

          buttonsList[bestMove].text = "0";
          buttonsList[bestMove].bg = Colors.black;

          playerTwo.playerMoves.add(buttonsList[bestMove].id); //add the btn to playerTwo's collection
          if( playerWon(playerTwo.playerMoves)){
            print("two wins");
            gameOver = true;
          }


          activePlayer = playerOne;
          buttonsList[bestMove].enabled = false;

        }
        //-----------------------------singlePlayer

      }
      else if( activePlayer.playerHandle == "playerTwo" ){


          buttonsList[gameBtnId].text = "0";
          buttonsList[gameBtnId].bg = Colors.black;

          playerTwo.playerMoves.add(buttonsList[gameBtnId].id); //add the btn to playerTwo's collection
          if( playerWon(playerTwo.playerMoves)){
            print("two wins");
            gameOver = true;
          }


          activePlayer = playerOne;
          //disable GameBtn
          buttonsList[gameBtnId].enabled = false;
      }

    });

  }

  void restart(){
    setState(() {
      buttonsList = generateNewGameBtns();
      playerOne.playerMoves.clear();
      playerTwo.playerMoves.clear();
      activePlayer = playerOne;
      gameOver = false;
    });
  }

  List<GameBtn> generateNewGameBtns(){
    var gameButtons = <GameBtn>[
      new GameBtn(id:0),
      new GameBtn(id:1),
      new GameBtn(id:2),
      new GameBtn(id:3),
      new GameBtn(id:4),
      new GameBtn(id:5),
      new GameBtn(id:6),
      new GameBtn(id:7),
      new GameBtn(id:8)
      
    ];
    return gameButtons;
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
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tic Tac Toe"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0
              ),
              itemCount: buttonsList.length,
              itemBuilder: (context, i)=> SizedBox(
                width: 100,
                height: 100,
                child: new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: buttonsList[i].enabled ? ()=>play(i ) : null,
                  child: new Text(
                    buttonsList[i].text,
                    style:  new TextStyle(color: Colors.white, fontSize: 20.0 ),
                  ),
                  color: buttonsList[i].bg,
                  disabledColor: buttonsList[i].bg,
                ),
              ),
            ),
          ),
          new RaisedButton(

              onPressed: ()=>restart(),
              child: new Text(
                "Restart",
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
              ),
            color: Colors.red,
            padding: const EdgeInsets.all(20.0),
          )
        ],
      )

    );
  }

}