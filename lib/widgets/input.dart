import 'package:ascii_image/constants/utils.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _userInput = TextEditingController();
  var output = "";
  bool isEnable = true;
  bool flag = true;
  followCommands(String comm) {
    if (comm == '/help') {
      var commands = "/signup --> to sign up as a new user\n"
          "/login --> to log in as an existing user\n"
          "/text/<your text here> --> to convert your text to ASCII Image\n"
          "/image --> to convert your image to ASCII Image\n"
          "/download/recent --> to download the last ASCII Image\n";
      setState(() {
        output = commands;
      });
    }
  }

  Widget takeInput() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(2.0),
                  child: const Text(
                    "C:/Users/Admin",
                    style: TextStyle(color: Color(0xFFc2ef11), fontSize: 20.0),
                  )),
              Flexible(
                child: SizedBox(
                  width: 1100.0,
                  child: TextField(
                    enabled: isEnable,
                    onSubmitted: (value) {
                      followCommands(value);
                      setState(() {
                        isEnable = false;
                      });
                    },
                    controller: _userInput,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    style: const TextStyle(
                        color: GlobalVariables.mainColor, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            output,
            style: const TextStyle(
              color: GlobalVariables.mainColor,
              fontSize: 13.0,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return takeInput();
  }
}
