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

  late final int _currentIndex = 0;
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex); //底部导航栏控制器

    _tabController = TabController(length: _pageList.length, vsync: this);
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
            onTap: (index) {
              setState(() {
                _pageController.jumpToPage(index);
              });
            },
          ),
        ),

        body: PageView(
          controller: _pageController,
          children: _pageList,
          onPageChanged: (index) {
            setState(() {
              _tabController.index = index;
            });
          },
        ),
      ),
    );
  }
}
