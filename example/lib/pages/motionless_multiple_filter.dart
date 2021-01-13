import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';
import 'package:flutter_custom_dropdown_example/config/filter_data.dart';

/// TODO : 多选实例
/// @param 
/// @return 
/// @author 丁平
/// created at 2021/1/12 11:06
///
class MotionlessMultipleFilter extends StatefulWidget {
  @override
  _MotionlessMultipleFilterState createState() => _MotionlessMultipleFilterState();
}

class _MotionlessMultipleFilterState extends State<MotionlessMultipleFilter> {
  String value1;
  String value2;
  String value3;

  @override
  Widget build(BuildContext context) {
    return Container(
        child:DefaultDropdownMenuController(
          onSelected: ({int menuIndex, dynamic data}) {
            print("int menuIndex, dynamic data = $menuIndex,$data");
            if(menuIndex == 0){
              value1 = '选中下标$menuIndex,\n选中内容$data';
            }
            if(menuIndex == 1){
              value2 = '选中下标$menuIndex,\n选中内容$data';
            }
            if(menuIndex == 2){
              value3 = '选中下标$menuIndex,\n选中内容$data';
            }
            setState(() {});
          },
          child:  Stack(
            children: [
              Column(
                children: [
                  Container(
                      color: Colors.white,
                      child: buildDropdownHeader()
                  ),
                  Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('交易类型选中 : ${value1??''}'),
                            const SizedBox(height: 10.0,),
                            Text('范围选中 : ${value2??''}'),
                            const SizedBox(height: 10.0,),
                            Text('排序选中 : ${value3??''}'),
                          ],
                        ),
                      )
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    color:const Color(0XFF00CCA9),
                    child: Text(
                        '交易价格筛选：多选,自定义输入 \n\n范围筛选：多选，\n\n排序类型筛选：多选,自定义收起',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: buildDropdownMenu(context))
            ],
          ),
        )
    );
  }


  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return DropdownHeader(
      isSideline : false,
      onTap: onTap,
      titles: ['交易价格','范围','排序'],
      selectIsChangingColor: true,
      specialModules: [1] ,///特殊模块,选中数据只亮起,不需要更改头部title,下标为1
    );
  }

  DropdownMenu buildDropdownMenu(BuildContext context) {
    return new DropdownMenu(
        menus: [
          DropdownMenuBuilder(
              builder : (BuildContext context) {
                return DropdownListMenu(
                  selectedIndex:  FilterData.amount[0],
                  isOperatingButton : true,
                  isCustomInput: true,
                  customInput: CustomInputClass(
                      startHintText : '最低价格(万)',
                      endHintText: '最高价格(万)',
                  ),
                  keyWords : "key",
                  isMultiple: true,
                  data: FilterData.amount,
                  valueKey: 'value',
                  itemBuilder: buildCheckItem,
                );
              },
              screenHeight : MediaQuery.of(context).size.height,
              draughtHeight : 60 * 7.0,
              bottomSpacingHeight : 168.0
          ),
          DropdownMenuBuilder(
              builder : (BuildContext context) {
                return DropdownListMenu(
                  selectedIndex:  FilterData.ranges[0],
                  isOperatingButton : false,
                  isMultiple: true,
                  keyWords : "key",
                  data: FilterData.ranges,
                  itemBuilder: buildCheckItem,
                );
              },
              screenHeight : MediaQuery.of(context).size.height,
              draughtHeight : 60 * 2.5,
              bottomSpacingHeight : 168.0
          ),
          DropdownMenuBuilder(
              builder : (BuildContext context) {
                return DropdownListMenu(
                  selectedIndex:  FilterData.sort[0],
                  isOperatingButton : true,
                  keyWords : "key",
                  isMultiple: true,
                  data: FilterData.sort,
                  itemBuilder: buildCheckItem,
                );
              },
              screenHeight : MediaQuery.of(context).size.height,
              draughtHeight : 60 * 6.66,
              bottomSpacingHeight : 168.0 + 50.0
          ),
        ]
    );
  }
}
