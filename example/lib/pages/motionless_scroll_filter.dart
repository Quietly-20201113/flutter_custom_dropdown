import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';
import 'package:flutter_custom_dropdown_example/config/filter_data.dart';

class MotionlessScrollFilter extends StatefulWidget {
  @override
  _MotionlessScrollFilterState createState() => _MotionlessScrollFilterState();
}

class _MotionlessScrollFilterState extends State<MotionlessScrollFilter> {
  late ScrollController scrollController;
  late GlobalKey globalKey;

  @override
  void initState() {
    scrollController = new ScrollController();
    globalKey = new GlobalKey();
    super.initState();
  }

  void _onTapHead(int index) {
    RenderObject renderObject = globalKey.currentContext!.findRenderObject()!;
    DropdownMenuController? controller = DefaultDropdownMenuController.of(globalKey.currentContext!);
    //
    scrollController
        .animateTo(scrollController.offset + renderObject.semanticBounds.height, duration: new Duration(milliseconds: 150), curve: Curves.ease)
        .whenComplete(() {
      controller?.show(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultDropdownMenuController(
      onSelected: ({int? menuIndex, dynamic data}) {
        print("int menuIndex, dynamic data = $menuIndex,$data");
      },
      child: Stack(
        children: [
          CustomScrollView(controller: scrollController, slivers: <Widget>[
            new SliverList(
                key: globalKey,
                delegate: new SliverChildBuilderDelegate((BuildContext context, int index) {
                  return new Container(
                    height: 200,
                    color: Colors.black26,
                    child: Text('高吧'),
                  );
                }, childCount: 1)),
            new SliverPersistentHeader(
              delegate: DropdownSliverChildBuilderDelegate(builder: (BuildContext context) {
                return Container(color: Theme.of(context).scaffoldBackgroundColor, child: buildDropdownHeader(onTap: _onTapHead));
              }),
              pinned: true,
              floating: true,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                height: 50,
                color: Color(0XFF00CCA9),
                child: Text('数量+$index'),
              );
            }, childCount: 300)),
          ]),
          Padding(padding: const EdgeInsets.only(top: 40), child: buildDropdownMenu(context))
        ],
      ),
    ));
  }

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback? onTap}) {
    return DropdownHeader(
      isSideline: false,
      onTap: onTap,
      titles: ['交易类型', '范围', '排序'],
      selectIsChangingColor: true,
      specialModules: [1],

      ///特殊模块,选中数据只亮起,不需要更改头部title,下标为1
    );
  }

  DropdownMenu buildDropdownMenu(BuildContext context) {
    return new DropdownMenu(menus: [
      DropdownMenuBuilder(
          builder: (BuildContext context) {
            return DropdownListMenu(
              selectedIndex: FilterData.housingTypes[0],
              isOperatingButton: false,
              keyWords: "key",
              data: FilterData.housingTypes,
              valueKey: 'value',
              itemBuilder: buildCheckItem,
            );
          },
          screenHeight: MediaQuery.of(context).size.height,
          draughtHeight: 60 * 2.5,
          bottomSpacingHeight: 168.0),
      DropdownMenuBuilder(
          builder: (BuildContext context) {
            return DropdownListMenu(
              selectedIndex: FilterData.ranges[0],
              isOperatingButton: false,
              keyWords: "key",
              data: FilterData.ranges,
              itemBuilder: buildCheckItem,
            );
          },
          screenHeight: MediaQuery.of(context).size.height,
          draughtHeight: 60 * 2.5,
          bottomSpacingHeight: 168.0),
      DropdownMenuBuilder(
          builder: (BuildContext context) {
            return DropdownListMenu(
              selectedIndex: FilterData.sort[0],
              isOperatingButton: false,
              keyWords: "key",
              data: FilterData.sort,
              itemBuilder: buildCheckItem,
            );
          },
          screenHeight: MediaQuery.of(context).size.height,
          draughtHeight: 60 * 6.66,
          bottomSpacingHeight: 168.0 + 50.0),
    ]);
  }
}
