import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
File? pickedImage;
String path1 = '';

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController _userInput = TextEditingController();
  var output = "";
  bool isEnable = true;
  bool flag = true;
  var newPage;


  void imagePickerOption(){
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),

          child: Container(
            color: Colors.white,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Upload Image From',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          //upload image from source gallery
                          pickImage(ImageSource.gallery);
                        },
                        icon: Icon(Icons.photo),
                        label: Text('Gallery'),
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.grey,
                        ),
                      ),

                      SizedBox(width: 10,),

                      ElevatedButton.icon(
                        onPressed: () {
                          //upload image from camera source
                          pickImage(ImageSource.camera);
                        },
                        icon: Icon(Icons.photo_camera),
                        label: Text('Camera'),
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.grey,
                        ),
                      ),

                      SizedBox(width: 10,),

                      ElevatedButton.icon(
                        onPressed: () {
                          //on pressing get back
                          Get.back();
                        },
                        icon: Icon(Icons.cancel),
                        label: Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //method to pick image
  //@param imageType to pass the source when buttons are tapped

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      //if photo true, store the path of image
      path1 = photo.path;
      final tempImage = File(photo.path);
      setState(() {
        //store the path in var
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }




  followCommands(String comm){
    if(comm == '/help') {
      var commands = "/signup --> to sign up as a new user\n"
          "/login --> to log in as an existing user\n"
          "/text/<your text here> --> to convert your text to ASCII Image\n"
          "/image --> to convert your image to ASCII Image\n"
          "/download/recent --> to download the last ASCII Image\n";
      output = commands;
      //_userInput.clear();
      newPage = Input();
    }

    else if(comm == '/signup')
    {
      newPage = Input();
    }

    else if(comm == '/login')
    {
      newPage = Input();
    }

    else if(comm == '/download/recent')
      {
        newPage = Input();
      }

    else if(comm.startsWith('/text/'))
      {
        newPage = Input();
        comm.trim();
        var userText = comm.split('/text/');
        output = userText[1];
        //print(userText.toString());
      }

    else if(comm == '/image')
      {
        // newPage = AlertDialog(
        //   title: Text('Upload Image'),
        //   actions: [
        //     ElevatedButton (onPressed: () {
        //       imagePickerOption();
        //     },
        //     child: Text('Upload'),
        //     style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.grey,
        //         side: BorderSide(width: 1.0, color: Colors.black)
        //     ),
        //   ),
        //
        //     ElevatedButton (onPressed: () => Get.back(closeOverlays: true),
        //       child: Text('Cancel'),
        //       style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.grey,
        //           side: BorderSide(width: 1.0, color: Colors.black)
        //       ),
        //     ),
        //
        //   ],
        // );
        imagePickerOption();
        newPage = Input();
      }
    else
      {
        var message = "No such command found,type /help to see all commands";
        output = message;
        newPage = Input();
      }
  }

  Widget takeInput(){
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    "C:/Users/Admin",
                    style: TextStyle(
                        color: Color(0xFFc2ef11),
                        fontSize: 20.0
                    ),
                  )
              ),

              Flexible(
                child: SizedBox(
                  width: 1100.0,
                  child:TextField(
                    enabled: isEnable,
                    onSubmitted: (value){
                      followCommands(value);
                      setState(() {
                        isEnable = false;
                      });
                    },
                    controller: _userInput,
                    decoration: InputDecoration(
                        focusedBorder:UnderlineInputBorder(
                            borderSide:BorderSide(color: Colors.black)
                        )
                    ),
                    style: TextStyle(
                        color: Color(0xFFc2ef11),
                        fontSize: 20.0
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 10,),
          Container(
            child: Text(
              output,
              style: TextStyle(
                color: Color(0xFFc2ef11),
                fontSize: 13.0,
              ),
            ),
          ),

          SizedBox(height: 10),
          Container(
            child: newPage,
          )
        ],
      ),
    );

  }
  @override
  Widget build(BuildContext context) {

    return takeInput();
  }
}

