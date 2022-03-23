import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//import 'video_info.dart';

class BiliInfo extends StatefulWidget {
  const BiliInfo({Key? key}) : super(key: key);

  @override
  _BiliInfoState createState() => _BiliInfoState();
}

class _BiliInfoState extends State<BiliInfo> {
  final TextEditingController _linkInput = TextEditingController();
  final _videoInfoList = [
    const TableRow(children: [
      Center(child: Text("key")),
      Center(child: Text("value")),
    ])
  ];
  String _text = "";
  String _status = "no get";

  void _setInput() {
    setState(() {
      if (_linkInput.text != '') {
        //var exp = pattern.exec(pathname)
        var rex =
            RegExp(r"(av)\d{1,}|(bv)\w*|(ss)\d{1,}|(ep)\d{1,}|(md)\d{1,}");
        var pat = rex.firstMatch(_linkInput.text);
        //print(pat?.group(0));
        //print(pat?.group(2));
        if (pat != null) {
          _text = pat.group(0)!;
        } else {
          _text = "no pat";
        }
      } else {
        _text = "null";
      }
    });
  }

  _getInfo() async {
    String baseUrl = "http://api.bilibili.com/x/web-interface/view?";
    Dio dio = Dio();

    if (_text.toLowerCase().startsWith("av")) {
      baseUrl += "aid=${_text.substring(2)}";
    } else if (_text.toLowerCase().startsWith("bv")) {
      baseUrl += "aid=$_text";
    }

    var _res = await dio.get(baseUrl,
        options: Options(responseType: ResponseType.plain));

    Map<String, dynamic> _resJson1 = json.decode(_res.data);
    setState(() {
      _status = _resJson1["message"];
    });

    if (_resJson1["code"] == 0) {
      setState(() {
        _videoInfoList.clear();

        _videoInfoList.add(const TableRow(children: [
          Center(child: Text("key")),
          SizedBox(width: 0.1),
          Text("value"),
        ]));
        _videoInfoList.add(TableRow(children: [
          const Center(child: Text("aid")),
          const SizedBox(width: 0.1),
          Text("${_resJson1["data"]["aid"]}"),
        ]));
        _videoInfoList.add(TableRow(children: [
          const Center(child: Text("bvid")),
          const SizedBox(width: 0.1),
          Text("${_resJson1["data"]["bvid"]}"),
        ]));
        _videoInfoList.add(TableRow(children: [
          const Center(child: Text("pic")),
          const SizedBox(width: 0.1),
          Image.network(
            _resJson1["data"]["pic"],
            height: 100,
          ),
        ]));
        _videoInfoList.add(TableRow(children: [
          const Center(child: Text("title")),
          const SizedBox(width: 0.1),
          Text("${_resJson1["data"]["title"]}"),
        ]));
        _videoInfoList.add(TableRow(children: [
          const Center(child: Text("desc")),
          const SizedBox(width: 0.1),
          Text("${_resJson1["data"]["desc"]}"),
        ]));
      });
    }
    //VideoInfo _resJson = User.fromJson(_resJson1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Flex(
          //详情主体
          direction: Axis.vertical,
          children: [
            TextField(
              //输入框
              onChanged: ((value) => _setInput()),
              controller: _linkInput,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: "链接",
                  hintText: "看着输点东西",
                  prefixIcon: Icon(Icons.link)),
            ),
            Flex(
                //中间结果和查询
                direction: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0, top: 0),
                    alignment: const Alignment(0, 0),
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      //设置四周边框
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                    child: Text(_text),
                  ),
                  ElevatedButton(
                      onPressed: _getInfo, child: const Text("获取信息")),
                  Container(
                    margin: const EdgeInsets.only(left: 0, top: 0),
                    alignment: const Alignment(0, 0),
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      //设置四周边框
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                    child: Text("状态-->$_status"),
                  ),
                ]),
          ]),
      Expanded(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            //margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
            //alignment: const Alignment(0, 0),

            decoration: const BoxDecoration(
              color: Colors.white, //背景色
              //设置四周圆角 角度
              //borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),

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
              children: _videoInfoList,
            ),
          )
        ],
      ))
    ]);
  }
}
