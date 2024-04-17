class Cards{
  final String name;
  bool showing;
  String shown = '';
  Cards({required this.name, required this.showing});

  void toggleShowing(){
    showing = !showing;
    if(showing){
      shown = name;
    }
    else{
      shown = '';
    }
  }

  void resetCard(){
    showing = false;
    shown = '';
  }

  String toString(){
    return 'name: $name, shown: $shown, showing: $showing';
  }
}