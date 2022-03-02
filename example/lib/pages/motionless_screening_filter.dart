import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';
import 'package:flutter_custom_dropdown_example/config/filter_data.dart';

/// TODO : 单选实例
/// @param
/// @return
/// @author 丁平
/// created at 2021/1/12 11:06
///
class MotionlessScreeningFilter extends StatefulWidget {
  @override
  _MotionlessScreeningFilterState createState() => _MotionlessScreeningFilterState();
}

class _MotionlessScreeningFilterState extends State<MotionlessScreeningFilter> {
  String? value1;
  String? value2;
  String? value3;

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
        }
        setState(() {});
      },
      child: Stack(
        children: [
          Column(
            children: [
              Container(color: Colors.white, child: buildDropdownHeader()),
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('交易类型选中 : ${value1 ?? ''}'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('范围选中 : ${value2 ?? ''}'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('排序选中 : ${value3 ?? ''}'),
                  ],
                ),
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
