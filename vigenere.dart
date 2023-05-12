class Vigenere {
  late String key;
  late List<List<String>> matrix;
  late String plainText, cipherText;

  Vigenere(String PT, String CT, String K) {
    plainText = PT.toUpperCase();
    cipherText = CT.toUpperCase();
    key = K.toUpperCase();
  }

  List<List<String>> matrixPrepare() {
    String Mat = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int count = 0, shift = 1;

    matrix = List.generate(
      26,
          (row) => List.generate(
        26,
            (col) => Mat[(row + col) % 26],
        growable: false,
      ),
      growable: false,
    );

    count++; // Increment count after each row

    return matrix;
  }

  String encryption() {
    matrixPrepare();
    int count = 0;
    for (int i = 0; i < plainText.length; i++) {
      int row = plainText.codeUnitAt(count) % 65;
      int col = (key.codeUnitAt(count++ % key.length));
      col %= 65;
      int c = (col + row) % 26;
      cipherText += String.fromCharCode(c + 65);
    }
    return cipherText;
  }

  String decryption() {
    int kCount = 0;
    for (int i = 0; i < cipherText.length; i++) {
      plainText += String.fromCharCode(((cipherText.codeUnitAt(i) - 65) -
                  (key.codeUnitAt(kCount) - 65) +
                  26) %
              26 +
          65);
      kCount = (kCount + 1) % key.length;
    }
    return plainText;
  }

  String printMat() {
    matrixPrepare();
    String mat = "";
    for (int row = 0; row < 26; ++row) {
      for (int column = 0; column < 26; ++column) {
        mat += matrix[row][column] + " ";
      }
      mat += "\n";
    }
    return mat;
  }
}
