import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({Key? key}) : super(key: key);

  @override
  Compose createState() => Compose();
}

class Compose extends State<ComposeScreen> {
  final postMessage = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final postError =
      SnackBar(content: Text('ERROR: must contain text to be posted.'));
  static String messagePost = "";
  bool isEnabled = true;

  message() {
    return messagePost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            iconSize: 30,
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.send),
              color: const Color(0xFFF0722A),
              onPressed: () {
                if (postMessage.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(postError);
                } else {
                  messagePost = postMessage.text;
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        body: Center(
            child: Form(
                key: _formkey,
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Positioned(
                      top: 30,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextFormField(
                            controller: postMessage,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            maxLines: 9,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(240)
                            ],
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'What would you like to say?',
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.transparent,
                              filled: true,
                            ),
                          ))),
                ]))));
  }
}
