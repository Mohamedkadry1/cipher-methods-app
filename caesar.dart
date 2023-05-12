import 'dart:io';
import 'main.dart';

class CaesarCipher {
  String message;
  int shift;

  CaesarCipher(this.message, this.shift);

  String encrypt() {
    String res = "";
    for (int i = 0; i < message.length; i++) {
      String c = message[i];
      if (c.toUpperCase() == c) {
        res += String.fromCharCode((c.codeUnitAt(0) + shift - 65) % 26 + 65);
      } else {
        res += String.fromCharCode((c.codeUnitAt(0) + shift - 97) % 26 + 97);
      }
    }
    return res;
  }
  String decrypt() {
    String plaintext = '';
    for (int i = 0; i < message.length; i++) {
      int charCode = message.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) { // uppercase letters
        charCode = ((charCode - 65 - shift) % 26) + 65;
      } else if (charCode >= 97 && charCode <= 122) { // lowercase letters
        charCode = ((charCode - 97 - shift) % 26) + 97;
      }
      plaintext += String.fromCharCode(charCode);
    }
    return plaintext;
  }

  // String decrypt() {
  //   return encrypt(26 - shift : -shift);
  // }
}

void main() {




  // String decryptedMessage = cipher.decrypt();
  // print("Decrypted message: $decryptedMessage");
}