import 'package:flutter/material.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RichText Controller Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: RichTextControllerDemo()),
    );
  }
}

class RichTextControllerDemo extends StatefulWidget {
  const RichTextControllerDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RichTextControllerDemoState createState() => _RichTextControllerDemoState();
}

class _RichTextControllerDemoState extends State<RichTextControllerDemo> {
  CustomRichTextController? _controller;

  // Get selected text
  TextSelection? selectedText;
  String? myReg;
  Color regColor = Colors.white;
  double regSize = 12.0;
  FontWeight regWeight = FontWeight.normal;
  // Initialize the RichTextController
  void initializeRichTextController() {
    _controller = CustomRichTextController(
      patternMatchMap: {
        // Add your initial patterns here
        RegExp(
          "num|Byte|bool|byte|short|int|long|float|double|boolean|khubi|char/g",
        ): const TextStyle(
          color: Colors.red,
          fontSize: 20,
        ),
        RegExp(
          "async|await|break|case|catch|class|const|continue|default|defferred|do|dynamic|else|enum|export|external/g",
        ): const TextStyle(
          color: Colors.blue,
          fontSize: 40.0,
          fontWeight: FontWeight.w900,
        ),
      },
      onMatch: (List<String> matches) {},
    );
  }

  @override
  void initState() {
    initializeRichTextController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 320.0,
            child: TextField(
              minLines: 1,
              maxLines: 10,
              controller: _controller,
              onChanged: (value) {},
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              selectedText = _controller!.selection;
              if (selectedText!.start != -1 && selectedText!.end != -1) {
                String text = _controller!.text.substring(
                  selectedText!.start,
                  selectedText!.end,
                );
                setState(() {
                  myReg = text;
                });
                // Update the patterns in the CustomRichTextController with the new regex.
                _controller?.updatePattern(
                  RegExp("$myReg|char/g"),
                  TextStyle(
                    color: regColor,
                    fontSize: regSize,
                    fontWeight: regWeight,
                  ),
                );
                debugPrint("Selected Text: $text");
                debugPrint("Text: $myReg");
              }
            },
            child: const Text('Get Selected Text'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    regColor = Colors.amber;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regColor = Colors.pink;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.pink,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regColor = Colors.blue;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regColor = Colors.green;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regColor = Colors.purple;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.purple,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regColor = Colors.brown;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.brown,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          //.....
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    regSize = 15.0;
                  });
                },
                child: const CircleAvatar(
                  child: Text("15"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regSize = 20.0;
                  });
                },
                child: const CircleAvatar(
                  child: Text("20"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regSize = 30.0;
                  });
                },
                child: const CircleAvatar(
                  child: Text("30"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regSize = 40.0;
                  });
                },
                child: const CircleAvatar(
                  child: Text("40"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regSize = 50.0;
                  });
                },
                child: const CircleAvatar(
                  child: Text("50"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regSize = 60.0;
                  });
                },
                child: const CircleAvatar(
                  child: Text("60"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    regWeight = FontWeight.w200;
                  });
                },
                child: const CircleAvatar(
                  child: Text("thin"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    regWeight = FontWeight.w900;
                  });
                },
                child: const CircleAvatar(
                  child: Text("bold"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomRichTextController extends RichTextController {
  CustomRichTextController({
    required patternMatchMap,
    required onMatch,
  }) : super(patternMatchMap: patternMatchMap, onMatch: onMatch);

  // Add a custom method to update the pattern and style
  void updatePattern(RegExp pattern, TextStyle style) {
    patternMatchMap![pattern] = style;
    notifyListeners();
  }
}
