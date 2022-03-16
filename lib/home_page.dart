import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _linkInput = TextEditingController();
  String _text = "hello";
  void _setInput() {
    setState(() {
      if (_linkInput.text != '') {
        _text = _linkInput.text;
      } else {
        _text = "null input";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        onChanged: ((value) => _setInput()),
        controller: _linkInput,
        autofocus: true,
        decoration: const InputDecoration(
            labelText: "链接", hintText: "测试", prefixIcon: Icon(Icons.link)),
      ),
      Flex(direction: Axis.horizontal, children: [
        ElevatedButton(onPressed: _setInput, child: const Text("push")),
        Text("->$_text"),
      ]),
    ]);
  }
}
