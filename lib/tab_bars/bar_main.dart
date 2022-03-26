import 'package:flutter/material.dart';

import 'test.dart';
import 'bili_info.dart';
import 'home.dart';

class ToolsTabBar extends StatefulWidget {
  const ToolsTabBar({Key? key}) : super(key: key);

  @override
  State<ToolsTabBar> createState() => _ToolsTabBarState();
}

class _ToolsTabBarState extends State<ToolsTabBar>
    with SingleTickerProviderStateMixin {
  static const _pageList = [
    HomePage(),
    BiliInfo(),
    TestPage(),
    Center(child: Text('home3')),
  ];

  /*底部导航栏控制部分
  late int _currentIndex = 0;
  late PageController _pageController; */
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    //_pageController = PageController(initialPage: _currentIndex);底部导航栏控制器

    _tabController = TabController(length: _pageList.length, vsync: this);
    //mController.addListener(() => _onTabChanged());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        //backgroundColor: Colors.yellow,
        appBar: AppBar(
          title: const Text("flpTools"),
          bottom: TabBar(
            tabs: const [
              Tab(text: "home"),
              Tab(text: "biliDownloder"),
              Tab(text: "testPage"),
              Tab(text: "TODO"),
            ],
            controller: _tabController,
            isScrollable: true,
          ),
        ),

        body: PageView(
          //controller: _pageController,底部导航栏用于跳转页面的控制
          children: _pageList,
          onPageChanged: (index) {
            setState(() {
              _tabController.index = index;
              // _currentIndex = index; 底部导航栏切换
            });
          },
        ),

/*底部导航栏主要内容
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: "h",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: "h",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: "h",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: "h",
                backgroundColor: Colors.blue),
          ],
        ), */
      ),
    );
  }
/* 暂时没什么用
  @override
  void dispose() {
    //super.dispose();
    //mController.dispose(); // 当整个页面dispose时，记得把控制器也dispose掉，释放内存
  }

  _onTabChanged() {
    //print(mController.index);
  } */
}
