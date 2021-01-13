import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'motionless_moving_filter.dart';
import 'motionless_multiple_filter.dart';
import 'motionless_screening_filter.dart';
import 'motionless_scroll_filter.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  // 底部栏切换
  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[ MotionlessScreeningFilter(),MotionlessMultipleFilter(),MotionlessMovingFilter(),MotionlessScrollFilter()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        onTap: _onBottomNavigationBarTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('普普通通')),
          BottomNavigationBarItem(
              icon: Icon(Icons.album),
              title: Text('多选主动')),
          BottomNavigationBarItem(
              icon: Icon(Icons.extension),
              title: Text('自主赋值')),
          BottomNavigationBarItem(
              icon: Icon(Icons.style),
              title: Text('滚滚动动')),
        ],
      ),
    );
  }
}
