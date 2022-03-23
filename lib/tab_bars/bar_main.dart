import 'package:flutter/material.dart';

import 'bili_info.dart';
import 'home.dart';

class ToolsTabBar extends StatefulWidget {
  const ToolsTabBar({Key? key}) : super(key: key);

  @override
  State<ToolsTabBar> createState() => _ToolsTabBarState();
}

class _ToolsTabBarState extends State<ToolsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController mController; // tab控制器

  @override
  void initState() {
    super.initState();

    mController = TabController(
      //initialIndex: 0,
      length: 3,
      vsync: this,
    );
    // 初始化TabController
    // 参数1：初试显示的tab位置
    // 参数2：tab的个数
    // 参数3：动画效果的异步处理，默认格式

    // 添加监听器
    mController.addListener(() => _onTabChanged());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text("flpTools"),
        bottom: TabBar(
          //labelColor: Colors.blue,

          tabs: const <Widget>[
            Tab(
              text: "home",
            ),
            Tab(
              text: "biliDownloder",
            ),
            Tab(
              text: "TODO",
            ),
          ], // 设置标题
          controller: mController, // 设置控制器
          isScrollable: false, //是否可滑动，设置不可滑动，则是tab的宽度等长
        ),
      ),

      body: TabBarView(
        controller: mController,
        children: const [
          HomePage(),
          BiliInfo(),
          Center(
            child: Text('home3'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose(); // 当整个页面dispose时，记得把控制器也dispose掉，释放内存
  }

  _onTabChanged() {
    //print(mController.index);
  }
}
