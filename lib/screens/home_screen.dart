import 'package:flutter/material.dart';
import 'package:mem/screens/game_screen.dart';
import 'package:mem/widgets/level_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  String color;
  int level;
  @override
  _HomeScreenState createState() => _HomeScreenState();

  HomeScreen({this.color = 'purple', this.level = 0});
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> colors = ['purple', 'purple', 'purple', 'purple','purple', 'purple', 'purple', 'purple', 'purple',];
  static List<int> pinks = [];
  late SharedPreferences prefs;

  loadData() async{
    prefs = await SharedPreferences.getInstance();
    List<String>? pinkString = prefs.getStringList('pinks');
    print(pinkString);
    for(int i=0; i<pinkString!.length; i++){
      pinks.add(int.parse(pinkString[i]));
    }
    print('pinks load $pinks');
  }

  saveData() async{
    List<String> pinkString = [];
    print('pinks save $pinks');
    if(widget.level != 0) {
      pinks.add(widget.level);
    }
    for(int i=0; i<pinks.length; i++){
      colors[pinks[i] - 1] = 'pink';
      pinkString.add('${pinks[i]}');
    }
    prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('pinks', pinkString);
    print(pinkString);
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    saveData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(200, 173, 192, 1.00),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                child: Text('mem', style: TextStyle(fontSize: 40, color: Color.fromRGBO(237,211,196,1.00)),),
              ),
              Container(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 40, color: Color.fromRGBO(8, 7, 8, 1.00)),
                  Text('HOME',
                      style: TextStyle(fontSize: 40,
                          color: Color.fromRGBO(8, 7, 8, 1.00),
                      )),
                ],
              ),
              Container(
                height: 50,
              ),
              Expanded(
                child: GridView.count(
                  primary: false,
                  padding: EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    LevelButton(level: 1, color: colors[0]),
                    LevelButton(level: 2, color: colors[1]),
                    LevelButton(level: 3, color: colors[2]),
                    LevelButton(level: 4, color: colors[3]),
                    LevelButton(level: 5, color: colors[4]),
                    LevelButton(level: 6, color: colors[5]),
                    LevelButton(level: 7, color: colors[6]),
                    LevelButton(level: 8, color: colors[7]),
                    LevelButton(level: 9, color: colors[8]),
                ],
        ),
              ),
            ],
          )
        )
    );
  }
}
