// import 'dart:io';
// import 'dart:math';

// List<String> value = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
// List<String> combination = [
//   '012',
//   '048',
//   '036',
//   '147',
//   '246',
//   '258',
//   '345',
//   '678'
// ];

// bool winner = false;
// bool xturn = true; // true for user, false for computer
// int mvcount = 0;

// void main() {
//   playGame();
// }

// void playGame() {
//   resetGame();
//   border();
//   char();
// }

// void resetGame() {
//   value = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
//   winner = false;
//   xturn = true;
//   mvcount = 0;
// }

// bool checkCombination(String comb, String check) {
//   List<int> number = comb.split('').map((item) {
//     return int.parse(item);
//   }).toList();

//   bool match = true;
//   for (final item in number) {
//     if (value[item] != check) {
//       match = false;
//       break;
//     }
//   }
//   return match;
// }

// void checkWinner(String player) {
//   for (final item in combination) {
//     bool combValid = checkCombination(item, player);
//     if (combValid) {
//       print('$player WON!');
//       winner = true;
//       break;
//     }
//   }
// }

// void char() {
//   if (xturn) {
//     // User's turn
//     print('Choose a number for X');
//     int num = int.parse(stdin.readLineSync()!);

//     if (value[num - 1] == 'x' || value[num - 1] == 'o') {
//       print('Invalid move, try again.');
//       char();
//       return;
//     }

//     value[num - 1] = 'x';
//   } else {
//     // Computer's turn
//     print('Computer is making a move...');
//     computerMove();
//   }

//   xturn = !xturn;
//   mvcount++;

//   border();
//   checkWinner('x');
//   checkWinner('o');

//   if (winner) {
//     askReplay();
//     return;
//   }

//   if (mvcount == 9) {
//     print('DRAW');
//     askReplay();
//   } else {
//     char();
//   }
// }

// void computerMove() {
//   // Try to find a winning move for the computer
//   for (final item in combination) {
//     int move = findBestMove(item, 'o');
//     if (move != -1) {
//       value[move] = 'o';
//       return;
//     }
//   }

//   // Try to block the player's winning move
//   for (final item in combination) {
//     int move = findBestMove(item, 'x');
//     if (move != -1) {
//       value[move] = 'o';
//       return;
//     }
//   }

//   // If no winning or blocking move, choose a random available move
//   List<int> availableMoves = [];
//   for (int i = 0; i < 9; i++) {
//     if (value[i] != 'x' && value[i] != 'o') {
//       availableMoves.add(i);
//     }
//   }
//   if (availableMoves.isNotEmpty) {
//     int randomMove = availableMoves[Random().nextInt(availableMoves.length)];
//     value[randomMove] = 'o';
//   }
// }

// int findBestMove(String combination, String player) {
//   List<int> indices = combination.split('').map(int.parse).toList();
//   int playerCount = 0;
//   int emptyIndex = -1;

//   for (var i in indices) {
//     if (value[i] == player) playerCount++;
//     if (value[i] != 'x' && value[i] != 'o') emptyIndex = i;
//   }

//   // If two of the positions are the player's and one is empty, return that empty index
//   return playerCount == 2 && emptyIndex != -1 ? emptyIndex : -1;
// }

// void askReplay() {
//   print('Do you want to play again? (y/n)');
//   String response = stdin.readLineSync()!.toLowerCase();
//   if (response == 'y') {
//     playGame();
//   } else {
//     print('Thanks for playing!');
//   }
// }

// void border() {
//   print('| ${value[0]} | ${value[1]} | ${value[2]} |');
//   print('|---|---|---|');
//   print('| ${value[3]} | ${value[4]} | ${value[5]} |');
//   print('|---|---|---|');
//   print('| ${value[6]} | ${value[7]} | ${value[8]} |');
// }
import 'dart:io';
import 'dart:math';

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
bool xturn = true; // true for user, false for computer
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

bool checkCombination(String comb, String check) {
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

void checkWinner(String player) {
  for (final item in combination) {
    bool combValid = checkCombination(item, player);
    if (combValid) {
      print('$player WON!');
      winner = true;
      break;
    }
  }
}

void char() {
  if (xturn) {
    // User's turn
    print('Choose a number for X');
    int num = int.parse(stdin.readLineSync()!);

    if (value[num - 1] == 'x' || value[num - 1] == 'o') {
      print('Invalid move, try again.');
      char();
      return;
    }

    value[num - 1] = 'x';
  } else {
    // Computer's turn
    print('Computer is making a move...');
    int bestMove = findBestMove();
    value[bestMove] = 'o';
  }

  xturn = !xturn;
  mvcount++;

  border();
  checkWinner('x');
  checkWinner('o');

  if (winner) {
    askReplay();
    return;
  }

  if (mvcount == 9) {
    print('DRAW');
    askReplay();
  } else {
    char();
  }
}

int findBestMove() {
  int bestScore = -1000;
  int move = -1;

  for (int i = 0; i < 9; i++) {
    if (value[i] != 'x' && value[i] != 'o') {
      // Make the move
      value[i] = 'o';
      int score = minimax(0, false); // Call minimax for the opponent
      value[i] = (i + 1).toString(); // Undo the move

      if (score > bestScore) {
        bestScore = score;
        move = i;
      }
    }
  }

  return move;
}

int minimax(int depth, bool isMaximizing) {
  String result = checkWinnerMiniMax();
  if (result != '') {
    if (result == 'o') return 10 - depth; // Computer wins
    if (result == 'x') return depth - 10; // Player wins
    return 0; // Draw
  }

  if (isMaximizing) {
    int bestScore = -1000;
    for (int i = 0; i < 9; i++) {
      if (value[i] != 'x' && value[i] != 'o') {
        value[i] = 'o';
        int score = minimax(depth + 1, false);
        value[i] = (i + 1).toString(); // Undo the move
        bestScore = max(score, bestScore);
      }
    }
    return bestScore;
  } else {
    int bestScore = 1000;
    for (int i = 0; i < 9; i++) {
      if (value[i] != 'x' && value[i] != 'o') {
        value[i] = 'x';
        int score = minimax(depth + 1, true);
        value[i] = (i + 1).toString(); // Undo the move
        bestScore = min(score, bestScore);
      }
    }
    return bestScore;
  }
}

String checkWinnerMiniMax() {
  for (final item in combination) {
    bool combX = checkCombination(item, 'x');
    bool combO = checkCombination(item, 'o');
    if (combX) return 'x';
    if (combO) return 'o';
  }

  // Check if there are any remaining moves
  bool movesLeft = value.any((element) => element != 'x' && element != 'o');
  return movesLeft ? '' : 'draw';
}

void askReplay() {
  print('Do you want to play again? (y/n)');
  String response = stdin.readLineSync()!.toLowerCase();
  if (response == 'y') {
    playGame();
  } else {
    print('Thanks for playing!');
  }
}

void border() {
  print(' --- --- --- ');
  print('| ${value[0]} | ${value[1]} | ${value[2]} |');
  print('|---|---|---|');
  print('| ${value[3]} | ${value[4]} | ${value[5]} |');
  print('|---|---|---|');
  print('| ${value[6]} | ${value[7]} | ${value[8]} |');
  print(' --- --- --- ');
}
