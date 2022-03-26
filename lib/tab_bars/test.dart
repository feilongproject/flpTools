import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with AutomaticKeepAliveClientMixin {
  String fileName = "";
  String fileExt = "";
  String filePath = "";
  String selectedDirectory = "";

  final _tableRows = [
    const TableRow(children: [
      Center(child: Text("key")),
      Text("value"),
    ])
  ];

  _testBtn1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      fileName = file.name;
      fileExt = file.extension!;
      filePath = file.path!;
      setState(() {
        _tableRows.clear();
        _tableRows.add(TableRow(children: [
          const Center(child: Text("fileName")),
          const SizedBox(width: 0.1),
          Text(fileName),
        ]));
        _tableRows.add(TableRow(children: [
          const Center(child: Text("fileExt")),
          const SizedBox(width: 0.1),
          Text(fileExt),
        ]));
        _tableRows.add(TableRow(children: [
          const Center(child: Text("filePath")),
          const SizedBox(width: 0.1),
          Text(filePath),
        ]));
      });
    }
  }

  _testBtn2() async {
    selectedDirectory = (await FilePicker.platform.getDirectoryPath())!;

    setState(() {
      _tableRows.clear();
      _tableRows.add(TableRow(children: [
        const Center(child: Text("selectedDirectory")),
        const SizedBox(width: 0.1),
        Text(selectedDirectory),
      ]));
    });
  }

  _testBtn3() async {
    setState(() {
      _tableRows.clear();
      _tableRows.add(TableRow(children: [
        const Center(child: Text("fileName")),
        const SizedBox(width: 0.1),
        Text(fileName),
      ]));
      _tableRows.add(TableRow(children: [
        const Center(child: Text("fileExt")),
        const SizedBox(width: 0.1),
        Text(fileExt),
      ]));
      _tableRows.add(TableRow(children: [
        const Center(child: Text("filePath")),
        const SizedBox(width: 0.1),
        Text(filePath),
      ]));
      _tableRows.add(TableRow(children: [
        const Center(child: Text("selectedDirectory")),
        const SizedBox(width: 0.1),
        Text(selectedDirectory),
      ]));
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ElevatedButton(onPressed: _testBtn1, child: const Text("选择单个文件")),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: IntrinsicColumnWidth(flex: 0.1),
                1: IntrinsicColumnWidth(flex: 0.01),
              },
              border: const TableBorder(
                top: BorderSide(width: 0.5),
                right: BorderSide(width: 0.5),
                bottom: BorderSide(width: 0.5),
                left: BorderSide(width: 0.5),
                horizontalInside: BorderSide(width: 1),
                //verticalInside: BorderSide(width: 1),
              ),
              children: _tableRows,
            ),
          ),
          ElevatedButton(onPressed: _testBtn2, child: const Text("选择文件夹")),
          ElevatedButton(onPressed: _testBtn3, child: const Text("加载")),
        ],
      ),
    );
  }
}
