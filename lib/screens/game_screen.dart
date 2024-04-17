import 'package:flutter/material.dart';
import 'package:mem/widgets/card_button.dart';
import 'package:mem/models/cards.dart';
import 'package:mem/models/game_logic.dart';
import 'package:flip_card/flip_card.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:mem/screens/home_screen.dart';

class GameScreen extends StatefulWidget {
  final int level;
  static const String id = 'game_screen';

  GameScreen({required this.level});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Game _game = Game();
  final stopwatch = Stopwatch();
  final _stopwatchTimer = StopWatchTimer();
  final _isHours = true;
  var timeDisplay = '';
  int tries = 0;
  int matches = 0;
  int crossAxisCount = 3;
  double fontSize = 40;

  @override
  void initState() {
    // TODO: implement initState
    _stopwatchTimer.onExecute.add(StopWatchExecute.start);
    _game.levelList(widget.level);
    crossAxis();
    _game.initGame();
    super.initState();
  }

  void crossAxis(){
    if(widget.level == 1){
      crossAxisCount = 2;
      fontSize = 40;
    }
    else if(widget.level>1 && widget.level<4){
      crossAxisCount = 3;
      fontSize = 25;
    }
    else if(widget.level>3 && widget.level<6){
      crossAxisCount = 4;
      fontSize = 15;
    }
    else{
      crossAxisCount = 5;
      fontSize = 10;
    }
  }

  bool gameWon(){
    if(_game.cardCount == matches*2){
      results();
      return true;
    }
    return false;
  }

  results() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(title: Text("Tries: $tries \nMatches: $matches \nTime: ${timeDisplay.substring(3)}"), actions: <Widget>[
            FlatButton(
                onPressed: () {
                },
                child: StreamBuilder<List<StopWatchRecord>>(
                  stream: _stopwatchTimer.records,
                  initialData: _stopwatchTimer.records.value,
                  builder: (context, snapshot) {
                    final value = snapshot.data;
                    if (value!.isEmpty) {
                      return Container();
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                timeDisplay,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),

                          ],
                        );
                      },
                    );
                  },
                )
              //Text("Next Level"),
            ),
            FlatButton(onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(color: 'pink', level: widget.level),
                ),
              );
            }, child: Text("Home"),
            ),
          ]),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(200, 173, 192, 1.00),
        body: SafeArea(child:
            Column(
              children: [
                Container(
                  height: 80,
                  child: Text('mem', style: TextStyle(fontSize: 40, color: Color.fromRGBO(237,211,196,1.00)),),
                ),
                Text('Tries: $tries', style: TextStyle(fontSize: 20, color: Color.fromRGBO(237,211,196,1.00)),),
                Text('Matches: $matches', style: TextStyle(fontSize: 20, color: Color.fromRGBO(237,211,196,1.00)),),
                StreamBuilder<int>(
                  stream: _stopwatchTimer.rawTime,
                  initialData: _stopwatchTimer.rawTime.value,
                  builder: (context, snapshot) {
                    final value = snapshot.data;
                    final displayTime =
                    StopWatchTimer.getDisplayTime(value!, hours: _isHours);
                    timeDisplay = displayTime;
                    return Text(
                      'Time: ' + displayTime.substring(3),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(237,211,196,1.00)
                      ),
                    );
                  },
                ),
                Flexible(
                  child: GridView.builder(
                      itemCount: _game.cardCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              tries++;
                              _game.shownCards![index] = _game.cardsList[index];
                              _game.matchCheck.add({index:_game.cardsList[index]});
                            });
                            if(_game.matchCheck.length == 2){
                              if(_game.matchCheck[0].values.first == _game.matchCheck[1].values.first){
                                _game.matchCheck.clear();
                                setState(() {
                                  matches++;
                                });
                              }
                              else{
                                Future.delayed(Duration(milliseconds: 800), (){
                                  setState(() {
                                    _game.shownCards![_game.matchCheck[0].keys.first] = '';
                                    _game.shownCards![_game.matchCheck[1].keys.first] = '';
                                    _game.matchCheck.clear();
                                  });
                                });
                              }
                            }
                            if(gameWon()){
                              _stopwatchTimer.onExecute.add(StopWatchExecute.stop);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Color.fromRGBO(119, 101, 227, 1.00),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Center(
                                  child: Text(_game.shownCards![index],
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: Color.fromRGBO(200, 173, 193, 1.00)
                                    ),)
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            )
        )
    );
  }
}
