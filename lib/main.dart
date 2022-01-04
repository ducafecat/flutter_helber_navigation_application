import 'package:flutter/material.dart';
import 'package:flutter_helber_navigation_application/pages/index.dart';
import 'package:flutter_helber_navigation_application/styles/index.dart';
import 'package:flutter_helber_navigation_application/utils/index.dart';
import 'package:flutter_helber_navigation_application/widgets/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: const MyHomePage(title: 'Flutter Helber Navigation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  void onIndexChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 扩展到Scaffold的底部
      resizeToAvoidBottomInset: false, // 不允许键盘事件影响界面
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // PageController 控制 PageView 呈现页面
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onIndexChanged,
        children: const [
          DemoPage(title: "home"),
          DemoPage(title: "map"),
          DemoPage(title: "chat"),
          DemoPage(title: "user"),
        ],
      ),
      // 底部带凹下的导航
      bottomNavigationBar: BuildNavigation(
        currentIndex: currentIndex,
        items: [
          NavigationItemModel(
            label: "home",
            icon: SvgIcon.layout,
          ),
          NavigationItemModel(
            label: "map",
            icon: SvgIcon.marker,
          ),
          NavigationItemModel(
            label: "chat",
            icon: SvgIcon.chat,
            count: 3,
          ),
          NavigationItemModel(
            label: "user",
            icon: SvgIcon.user,
          ),
        ],
        onTap: onIndexChanged, // 切换tab事件
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_circle_rounded, size: 50),
      ), // 浮动按钮
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // 浮动按钮 停靠在底部中间位置
    );
  }
}
