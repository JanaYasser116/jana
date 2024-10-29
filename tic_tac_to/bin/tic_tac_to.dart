import 'dart:io';

List<String> value = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> combination = [
  '012',
  '048',
  '036',
  '147',
  '246',
  '258',
  '345',
  '678'
];

bool winner = false;
bool xturn = true;
int mvcount = 0;

void main() {
  playGame();
}

void playGame() {
  resetGame();
  border();
  char();
}

void resetGame() {
  value = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  winner = false;
  xturn = true;
  mvcount = 0;
}

bool check_combination(String comb, String check) {
  List<int> number = comb.split('').map((item) {
    return int.parse(item);
  }).toList();

  bool match = true;
  for (final item in number) {
    if (value[item] != check) {
      match = false;
      break;
    }
  }
  return match;
}

void check_winner(String player) {
  for (final item in combination) {
    bool comb_valid = check_combination(item, player);
    if (comb_valid == true) {
      print('$player WONNN');
      winner = true;
      break;
    }
  }
}

void char() {
  print('Choose a number for ${xturn == true ? 'x' : 'o'}');
  int num = int.parse(stdin.readLineSync()!);

  if (value[num - 1] == 'x' || value[num - 1] == 'o') {
    print('Invalid move, try again.');
    char();
    return;
  }

  value[num - 1] = xturn ? 'x' : 'o';
  xturn = !xturn;
  mvcount++;

  if (mvcount == 9 && winner == false) {
    print('DRAW');
    askReplay();
    return;
  } else {
    border();
    check_winner('x');
    check_winner('o');
    if (winner == true) {
      askReplay();
      return;
    } else {
      char();
    }
  }
}

void askReplay() {
  print('Do you want to play again? (y/n)');
  String response = stdin.readLineSync()!.toLowerCase();

  if (response == 'y') {
    playGame();
  } else {
    print('i hope u enjoy ittt');
  }
}

void border() {
  print('|${value[0]} | ${value[1]} | ${value[2]} |');
  print('|--|---|---|');
  print('|${value[3]} | ${value[4]} | ${value[5]} |');
  print('|--|---|---|');
  print('|${value[6]} | ${value[7]} | ${value[8]} |');
}
