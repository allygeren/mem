import 'package:flutter/material.dart';
import 'package:mem/screens/game_screen.dart';
import 'package:mem/models/cards.dart';

class CardButton extends StatefulWidget {
  final Cards card;
  CardButton({required this.card});

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  static int guesses = 0;
  static List<Cards> cardsList = [];

  @override
  Widget build(BuildContext context) {
    cardsList.add(widget.card);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(119, 101, 227, 1.00),
        ),
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text("${widget.card.shown}",
              style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(200, 173, 193, 1.00)
              ),)
        ),
      ),
      onTap: () async{
        guesses++;
        setState(() {
          widget.card.toggleShowing();
        });
        if(guesses == 2){
          await Future.delayed(const Duration(seconds: 1));
          guesses = 0;
          setState(() {
            widget.card.toggleShowing();
            for(Cards c in cardsList){
              c.resetCard();
              print(c);
            }
          });
        }
       },
    );
  }
}
