class Playfair {
  late String key;
  late List<List<String>> matrix;
  late String plainText, cipherText;


  Playfair(String PT, String CT, String K) {
    plainText = PT.toUpperCase();
    cipherText = CT.toUpperCase();
    key = K.toUpperCase();
  }

  List<List<String>> matrixPrepare() {
    String matrixWithoutPrepare = key + "ABCDEFGHIKLMNOPQRSTUVWXYZ";
    String matrixLetters = "";

    for (var c in matrixWithoutPrepare.runes
        .map((rune) => String.fromCharCode(rune))) {
      if (c == 'J' && matrixLetters.indexOf('I') == -1) {
        matrixLetters += 'I';
      } else if (matrixLetters.indexOf(c) == -1) {
        matrixLetters += c;
      }
    }

    int count = 0;
    var matrix = List.generate(5, (_) => List.generate(5, (_) => ""));
    for (var row = 0; row < 5; ++row) {
      for (var col = 0; col < 5; ++col) {
        matrix[row][col] = matrixLetters[count++];
      }
    }

    return matrix;
  }

  String encryption() {
    matrix = matrixPrepare();

    if (plainText.length % 2 != 0) {
      plainText += "X";
    }

    for (var i = 0; i < plainText.length; i += 2) {
      var firstChar = plainText[i];
      var secondChar = plainText[i + 1];
      int c1 = 0, r1 = 0, c2 = 0, r2 = 0;

      for (var row = 0; row < 5; ++row) {
        for (var column = 0; column < 5; ++column) {
          if (matrix[row][column] == firstChar) {
            c1 = column;
            r1 = row;
          }

          if (matrix[row][column] == secondChar) {
            c2 = column;
            r2 = row;
          }
        }
      }

      if (r1 == r2) {
        c1 = (c1 + 1) % 5;
        c2 = (c2 + 1) % 5;
        cipherText += (matrix[r1][c1]);
        cipherText += (matrix[r2][c2]);
      } else if (c1 == c2) {
        r1 = (r1 + 1) % 5;
        r2 = (r2 + 1) % 5;
        cipherText += (matrix[r1][c1]);
        cipherText += (matrix[r2][c2]);
      } else {
        cipherText += (matrix[r1][c2]);
        cipherText += (matrix[r2][c1]);
      }
    }

    return cipherText;
  }

  String decryption() {
    matrix = matrixPrepare();

    if (cipherText.length % 2 != 0) {
      cipherText += 'X';
    }

    for (var i = 0; i < cipherText.length; i += 2) {
      var firstChar = cipherText[i];
      var secondChar = cipherText[i + 1];
      int c1 = 0, r1 = 0, c2 = 0, r2 = 0;

      for (var row = 0; row < 5; ++row) {
        for (var column = 0; column < 5; ++column) {
          if (matrix[row][column] == firstChar) {
            c1 = column;
            r1 = row;
          }

          if (matrix[row][column] == secondChar) {
            c2 = column;
            r2 = row;
          }
        }
      }

      if (r1 == r2) {
        c1 = (c1 - 1) < 0 ? (c1 - 1 + 5) : (c1 - 1);
        c2 = (c2 - 1) < 0 ? (c2 - 1 + 5) : (c2 - 1);
        plainText += matrix[r1][c1];
        plainText += matrix[r2][c2];
      } else if (c1 == c2) {
        r1 = (r1 - 1) < 0 ? (r1 - 1 + 5) : (r1 - 1);
        r2 = (r2 - 1) < 0 ? (r2 - 1 + 5) : (r2 - 1);
        plainText += (matrix[r1][c1]);
        plainText += (matrix[r2][c2]);
      } else {
        plainText += (matrix[r1][c2]);
        plainText += (matrix[r2][c1]);
      }
    }

    return plainText;
  }

  String printMat() {
    matrix = matrixPrepare();
    String mat = "";

    for (var row = 0; row < 5; ++row) {
      for (var column = 0; column < 5; ++column) {
        mat += matrix[row][column] + " ";
      }
      mat += "\n";
    }

    return mat.toString();
  }
}