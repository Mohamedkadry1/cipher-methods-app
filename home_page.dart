import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:try_to_catch_error/playfair.dart';
import 'package:try_to_catch_error/vigenere.dart';

import 'caesar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedItem = 'Ceaser';
  TextEditingController message = new TextEditingController();
  TextInputType inputType = TextInputType.text;
  TextInputFormatter inputFormatter = FilteringTextInputFormatter.digitsOnly;
  TextEditingController key = new TextEditingController();
  String encryptionType = 'encrypt';
  var list = ['Ceaser', 'Vigenere', 'playFair'];
  var encryptedMessage;
  var decryptedMessage;
  String? res = '';
  late String? matrix;
  // bool flag = false;
  void onTextChanged() {
    // if (flag == false) key.clear();
    setState(() {
      if (selectedItem == 'Ceaser') {
        inputType = TextInputType.number;
        inputFormatter = FilteringTextInputFormatter.digitsOnly;
      } else {
        inputType = TextInputType.text;
        inputFormatter = FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white10,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                  // LengthLimitingTextInputFormatter(5), // limit to 5 digits
                ],
                controller: message,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.message,
                      color: Color(0xff7373E3),
                    ),
                    label: Text('Enter your message',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black87,
                        )),
                    labelStyle: TextStyle(fontSize: 14),
                    enabled: true,
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xff7373E3),
                        ))),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: inputType,
                inputFormatters: [inputFormatter],
                controller: key,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key, color: Color(0xff7373E3)),
                    label: Text('Enter your key',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black87,
                        )),
                    labelStyle: TextStyle(fontSize: 14),
                    enabled: true,
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                        BorderSide(width: 2, color: Color(0xff7373E3)))),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.teal.shade400,
                  color: Color(0xffE6E6FA),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          color: Color(0xff7373E3),
                          height: 2,
                        ),
                        Text("Select an option",
                            style: TextStyle(
                                color: Color(0xff212121),
                                fontSize: 18,
                                fontWeight: FontWeight.w900)),
                        Container(
                          width: 80,
                          color: Color(0xff7373E3),
                          height: 2,
                        ),
                      ],
                    ),
                    SizedBox(width: 20, height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Radio(
                            activeColor: Color(0xff2A2AD1),
                            autofocus: true,
                            value: 'encrypt',
                            groupValue: encryptionType,
                            onChanged: (val) {
                              setState(() {
                                encryptionType = val!;
                                print(encryptionType);
                              });
                            }),
                        Text("Encryption",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Color(0xff212121),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Radio(
                            activeColor: Color(0xff2A2AD1),
                            value: 'decrypt',
                            groupValue: encryptionType,
                            onChanged: (val) {
                              setState(() {
                                encryptionType = val!;
                                print(encryptionType);
                              });
                            }),
                        Text(
                          "Decryption",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Color(0xff212121),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: selectedItem,
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.code_outlined),
                        focusColor: Colors.red,
                        decoration: InputDecoration(
                            enabled: true,
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff7373E3))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem = newValue!;
                            onTextChanged();
                            // flag = true;
                          });
                        },
                        items: <String>[
                          'Ceaser',
                          'Vigenere',
                          'Playfair',
                          'DES',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffE6E6FA),
                ),
                margin: EdgeInsets.only(top: 5),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 90,
                          color: Color(0xff7373E3),
                          height: 2,
                        ),
                        Text(
                          "Result",
                          style: TextStyle(
                              color: Color(0xff212121),
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                        Container(
                          width: 90,
                          color: Color(0xff7373E3),
                          height: 2,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: encryptionType == 'encrypt'
                              ? Icon(
                                  Icons.lock_outline,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.lock_open_outlined,
                                  size: 30,
                                ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: 200,
                          child: Center(
                            child: Text(
                              res.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xff9A9AEB),
                          side: BorderSide(width: 1, color: Color(0xff7373E3))),
                      onPressed: () {
                        setState(() {
                          onTextChanged();
                          var x = key.text;
                          if (selectedItem == 'Ceaser' &&
                              encryptionType == 'encrypt') {
                            CaesarCipher cipher =
                                CaesarCipher(message.text, int.parse(x));
                            encryptedMessage = cipher.encrypt();
                            res = encryptedMessage;
                          } else if (selectedItem == 'Ceaser' &&
                              encryptionType == 'decrypt') {
                            CaesarCipher cipher =
                                CaesarCipher(message.text, int.parse(x));
                            decryptedMessage = cipher.decrypt();
                            res = decryptedMessage;
                          } else if (selectedItem == 'Vigenere' &&
                              encryptionType == 'encrypt') {
                            Vigenere v = Vigenere(message.text, '', key.text);
                            matrix = v.printMat();
                            res = v.encryption();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Matrix = '),
                                content: Text(
                                  matrix!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else if (selectedItem == 'Vigenere' &&
                              encryptionType == 'decrypt') {
                            Vigenere v = Vigenere('', message.text, key.text);
                            res = v.decryption();
                            matrix = v.printMat();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Matrix = '),
                                content: Text(
                                  matrix!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else if (selectedItem == 'Playfair' &&
                              encryptionType == 'decrypt') {
                            Playfair p = Playfair('', message.text, key.text);
                            res = p.decryption();
                            matrix = p.printMat();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Matrix = '),
                                content: Text(
                                  matrix!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else if (selectedItem == 'Playfair' &&
                              encryptionType == 'encrypt') {
                            Playfair p = Playfair(message.text, '', key.text);
                            res = p.encryption();
                            matrix = p.printMat();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Matrix = '),
                                content: Text(
                                  matrix!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        'Convert',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
