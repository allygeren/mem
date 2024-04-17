import 'package:flutter/material.dart';
import 'package:mem/screens/game_screen.dart';

class LevelButton extends StatefulWidget {
  final int level;
  String color;
  LevelButton({required this.level, this.color = 'purple'});

  @override
  _LevelButtonState createState() => _LevelButtonState();
}

class _LevelButtonState extends State<LevelButton> {
  Color c = Color.fromRGBO(119, 101, 227, 1.00);

  @override
  void initState() {
    // TODO: implement initState
    if(widget.color == 'pink'){
      c = Color.fromRGBO(237,211,196,1.00);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: c,
        ),
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text("${widget.level}",
              style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(200, 173, 193, 1.00)
              ),)
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(level: widget.level,)));
        //Navigator.pushNamed(context, GameScreen.id);
      },
    );
  }
}
