import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';
import 'package:flutter_custom_dropdown_example/config/filter_data.dart';
import 'package:flutter_custom_dropdown_example/config/index.dart';

/// 自定义
/// @param
/// @return
/// @author 丁平
/// created at 2021/1/12 17:04
///
class MotionlessMovingFilter extends StatefulWidget {
  @override
  _MotionlessMovingFilterState createState() => _MotionlessMovingFilterState();
}

class _MotionlessMovingFilterState extends State<MotionlessMovingFilter> {
  DropdownMenuController? controller;
  late GlobalKey _globalKey;
  late ScrollController scrollController;
  String? value1;
  String? value2;
  String? value3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalKey = new GlobalKey();
    scrollController = new ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  void _onTapHead(BuildContext context, int index) {
    controller = DefaultDropdownMenuController.of(_globalKey.currentContext!);
    scrollController.animateTo(scrollController.offset, duration: const Duration(milliseconds: 150), curve: Curves.ease).whenComplete(() {
      controller?.show(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultDropdownMenuController(
      onSelected: ({int? menuIndex, dynamic data}) {
        print("int menuIndex, dynamic data = $menuIndex,$data");
        if (menuIndex == 0) {
          value1 = '选中下标$menuIndex,\n选中内容$data';
        }
        if (menuIndex == 1) {
          value2 = '选中下标$menuIndex,\n选中内容$data';
        }
        if (menuIndex == 2) {
          value3 = '选中下标$menuIndex,\n选中内容$data';
          if (data['urgency'] != '-1') {
            ////自定义赋值这么搞的
            controller?.assignment({'title': '更多---'}, menuIndex);
          } else {
            controller?.assignment({'title': '更多'}, menuIndex);
          }
        }
        setState(() {});
      },
      child: Stack(
        key: _globalKey,
        children: [
          Column(
            children: [
              Container(
                  color: Colors.white,
                  child: buildDropdownHeader(onTap: (index) {
                    if (index == 1) {
                      _openAddEntryDialog(context, index);
                      controller?.show(index);
                      controller?.hide(); //打开
                    } else {
                      _onTapHead(context, index);
                    }
                  })),
              Expanded(
                  child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                        return Container(
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: Text("$index"),
                        );
                      }, childCount: 20),
                      itemExtent: 50),
                ],
              )),
              Container(
                alignment: Alignment.centerLeft,
                color: const Color(0XFF00CCA9),
                child: Text(
                  '交易类型筛选：单选,不提供选中头部回显,在元数据中剔除title字段即可 \n\n范围筛选：单选，不提供选中头部回显，但是提供选中头部颜色更改，使用specialModules属性标注，\n\n排序类型筛选：单选，提供选中内容头部回显不剔除title字段，设置selectIsChangingColor属性',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          Padding(padding: const EdgeInsets.only(top: 40), child: buildDropdownMenu(context))
        ],
      ),
    ));
  }

  _openAddEntryDialog(context, index) async {
    controller = DefaultDropdownMenuController.of(_globalKey.currentContext!);
    var res = await Navigator.of(context).push(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return TakeOff();
        },
        fullscreenDialog: true));
    if (res == null || res['urgency'] == '-1') {
      controller?.select({'title': '自定义内容'}, index);
    } else {
      controller?.select({'title': '自定义内容呀'}, index);
    }
  }

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback? onTap}) {
    return DropdownHeader(
      isSideline: false,
      onTap: onTap,
      titles: ['交易类型', '自定义内容', '更多'],
      selectIsChangingColor: true,
      specialModules: [1, 2],

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
            return SizedBox();
          },
          draughtHeight: 0.0),
      DropdownMenuBuilder(
          builder: (BuildContext context) {
            return DropdownMenuCustomize(
              data: [],
              itemBuilder: financialMoreTemplate,
            );
          },
          screenHeight: MediaQuery.of(context).size.height,
          draughtHeight: 60 * 6.66,
          bottomSpacingHeight: 168.0 + 50.0),
    ]);
  }
}

Widget financialMoreTemplate(BuildContext context, List<dynamic> data, DropdownMenuController? controller) {
  return _FinancialMoreTemplate(controller);
}

class _FinancialMoreTemplate extends StatefulWidget {
  final DropdownMenuController? controller;

  const _FinancialMoreTemplate(this.controller);

  @override
  __FinancialMoreTemplateState createState() => __FinancialMoreTemplateState();
}

class __FinancialMoreTemplateState extends State<_FinancialMoreTemplate> {
  Map<String, Object?> _map = {
    'urgency': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(0.0),
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '急迫程度',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0XFF303133)),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      GridView.count(
                        childAspectRatio: 109 / 34,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        primary: false,
                        shrinkWrap: true,

                        ///添加当前可解决Vertical viewport was given unbounded height.报错
                        crossAxisCount: 3,
                        children: _urgencyList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 34.0,
                ),
              ],
            )),
            FilterButton(
              fixOnTap: () {
                assert(widget.controller != null);
                widget.controller!.select(_map);
              },
              resetOnTap: () {},
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _urgencyList() {
    return FilterData.moreListMap.map((item) {
      bool _isSelected = false;
      if (_map['urgency'] != null) {
        _isSelected = _map['urgency'] == item['key'];
      } else {
        _isSelected = item['key'] == '-1';
      }
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Map<String, Object?> _item = {}..addEntries(_map.entries);
          if (item['key'] == -1) {
            _item['urgency'] = null;
          } else {
            _item['urgency'] = item['key'];
          }
          setState(() {
            _map = {}..addEntries(_item.entries);
          });
        },
        child: LabelWidget(
          isBorder: !_isSelected,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
          border: _isSelected ? null : Border.all(width: .5, color: Color(0XFFD9D9D9)),
          fontColor: _isSelected ? Color(0XFF00CCA9) : Color(0XFF909399),
          labelBgColor: _isSelected ? Color(0X2100CCA9) : Colors.white,
          fontSize: 14,
          tagItem: {'name': item['value']},
        ),
      );
    }).toList();
  }
}

class TakeOff extends StatefulWidget {
  @override
  _TakeOffState createState() => _TakeOffState();
}

class _TakeOffState extends State<TakeOff> {
  Map<String, Object?> _map = {
    'urgency': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(0.0),
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '急迫程度',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0XFF303133)),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      GridView.count(
                        childAspectRatio: 109 / 34,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        primary: false,
                        shrinkWrap: true,

                        ///添加当前可解决Vertical viewport was given unbounded height.报错
                        crossAxisCount: 3,
                        children: _urgencyList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 34.0,
                ),
              ],
            )),
            FilterButton(
              fixOnTap: () {
                Navigator.pop(context, _map);
              },
              resetOnTap: () {},
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _urgencyList() {
    return FilterData.moreListMap.map((item) {
      bool _isSelected = false;
      if (_map['urgency'] != null) {
        _isSelected = _map['urgency'] == item['key'];
      } else {
        _isSelected = item['key'] == '-1';
      }
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Map<String, Object?> _item = {}..addEntries(_map.entries);
          if (item['key'] == -1) {
            _item['urgency'] = null;
          } else {
            _item['urgency'] = item['key'];
          }
          setState(() {
            _map = {}..addEntries(_item.entries);
          });
        },
        child: LabelWidget(
          isBorder: !_isSelected,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
          border: _isSelected ? null : Border.all(width: .5, color: Color(0XFFD9D9D9)),
          fontColor: _isSelected ? Color(0XFF00CCA9) : Color(0XFF909399),
          labelBgColor: _isSelected ? Color(0X2100CCA9) : Colors.white,
          fontSize: 14,
          tagItem: {'name': item['value']},
        ),
      );
    }).toList();
  }
}
