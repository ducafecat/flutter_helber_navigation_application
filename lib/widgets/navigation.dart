import 'package:flutter/material.dart';
import 'index.dart';

class BuildNavigation extends StatelessWidget {
  final int currentIndex;
  final List<NavigationItemModel> items;
  final Function(int) onTap;

  const BuildNavigation({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ws = <Widget>[];
    var theme = Theme.of(context).bottomNavigationBarTheme;
    for (var i = 0; i < items.length; i++) {
      var labelStyle = currentIndex == i
          ? theme.selectedLabelStyle
          : theme.unselectedLabelStyle;
      var color = currentIndex == i
          ? theme.selectedItemColor
          : theme.unselectedItemColor;
      var gap = (items.length / 2).ceil();
      if (gap == i) ws.add(const SizedBox(width: 60));
      ws.add(Expanded(
        child: MaterialButton(
          elevation: 0,
          padding: const EdgeInsets.all(0),
          onPressed: () => onTap(i),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgIconWidget(
                    items[i].icon,
                    size: 20,
                    color: currentIndex != i ? color : null,
                  ),
                  Positioned(
                    right: -8,
                    top: -5,
                    child: items[i].count > 0
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                            ),
                            height: 16,
                            constraints: const BoxConstraints(
                              minWidth: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              items[i].count <= 99
                                  ? items[i].count.toString()
                                  : '99+',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                items[i].label,
                maxLines: 1,
                style: labelStyle?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ));
    }
    return BottomAppBar(
      color: theme.backgroundColor,
      shape: const CircularNotchedRectangle(), // 中间凹下的形状
      notchMargin: 10, // 凹下的尺寸
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(children: ws),
      ),
    );
  }
}

class NavigationItemModel {
  final String label;
  final String icon;
  final int count;

  NavigationItemModel({
    required this.label,
    required this.icon,
    this.count = 0,
  });
}
