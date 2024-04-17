class Game{

  int cardCount = 8;
  List<String>? shownCards;

  List<String> cardsList = [
    'cat',
    'cat',
    'dog',
    'dog',
    'fish',
    'fish',
    'bunny',
    'bunny',
    'mouse',
    'mouse',
    'hamster',
    'hamster',
    'frog',
    'frog',
    'snake',
    'snake',
    'bird',
    'bird',
    'lizard',
    'lizard',
    'llama',
    'llama',
    'cow',
    'cow',
    'horse',
    'horse',
    'pig',
    'pig',
    'seal',
    'seal',
    'dolphin',
    'dolphin',
    'turtle',
    'turtle',
    'hyena',
    'hyena',
    'deer',
    'deer',
    'fox',
    'fox'
  ];

  List<Map<int, String>> matchCheck = [];

  void levelList(int level){
    int cards = 6;
    List<String> newList = [];
    if(level == 1){
      cards = 6;
    }
    if(level == 2){
      cards = 10;
    }
    if(level == 3){
      cards = 14;
    }
    if(level == 4){
      cards = 18;
    }
    if(level == 5){
      cards = 22;
    }
    if(level == 6){
      cards = 26;
    }
    if(level == 7){
      cards = 30;
    }
    if(level == 8){
      cards = 34;
    }
    if(level == 9){
      cards = cardsList.length;
    }
    for(int i=0; i<cards; i++){
      newList.add(cardsList[i]);
    }
    cardsList = newList;
    cardCount = cardsList.length;
  }


  void initGame(){
    cardsList.shuffle();
    shownCards = List.generate(cardCount, (index) => ' ');
  }
}