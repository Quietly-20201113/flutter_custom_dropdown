# flutter_custom_dropdown

> 创建命令

```dart
flutter create --org com.example --template=plugin --platforms=android,ios -a java -i objc flutter_custom_dropdown
```

**本组件由Github作者[best-flutter](https://github.com/best-flutter)插件[flutter_dropdown_menu](https://github.com/best-flutter/flutter_dropdown_menu)更改而来,由于更新问题,以及使用上不满足业务问题自己修改了相关bug做了更新迭代,所以重新集成为新插件**



![示例图1](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown1.gif "示例图1")

***DefaultDropdownMenuController***

> 功能：包裹页面提供默认Controller

|  功能参数  | 是否必要 |  类型  | 备注                                          |
| :--------: | :------: | :----: | :-------------------------------------------- |
| onSelected |   true   |  bool  | 选中时，触发controller.selected时会回调此方法 |
|   child    |   true   | widget | 包裹内容                                      |

***DropdownHeader***

> 功能：下拉头部模块

|       功能参数        | 是否必要 |     类型     | 备注                                                         |
| :-------------------: | :------: | :----------: | :----------------------------------------------------------- |
|      isSideline       |  false   |     bool     | 是否需要分割线                                               |
|         onTap         |  false   |     func     | 触发头部回调,内部自动提供,自定义头部事件需自定义             |
|        titles         |   true   | List<String> | 头部显示title列表                                            |
| selectIsChangingColor |  false   |     bool     | 选中是否更改回显title字段可specialModules联合使用            |
|    specialModules     |  false   |  List<int>   | 选中是否只改变title颜色不更改title文字,此功能selectIsChangingColor必须为true,权重大于selectIsChangingColor功能 |

***DropdownMenu***

> 功能：悬停筛选模块

|   功能参数    | 是否必要 |              类型               | 备注                                       |
| :-----------: | :------: | :-----------------------------: | ------------------------------------------ |
|     menus     |   true   |    List<DropdownMenuBuilder>    | list长度必须与titles长度一致               |
| packUpHeight  |  false   |             double              | 收起长度不够时可自行添加                   |
| hideDuration  |  false   |            Duration             | 收起时自定义时长                           |
| showDuration  |  false   |            Duration             | 展开时自定义时长                           |
|   showCurve   |  false   |              Curve              | 自定义动画                                 |
|   hideCurve   |  false   |              Curve              | 自定义动画                                 |
|     blur      |  false   |             double              | 蒙层透明值                                 |
|    onHide     |  false   |          VoidCallback           | 蒙层触发操作回调                           |
|  switchStyle  |  false   | DropdownMenuShowHideSwitchStyle | 菜单样式                                   |
| maxMenuHeight |  false   |             double              | 最大高度,未提供自动计算时,需要指定最大高度 |

***DropdownMenuBuilder***

> 功能：menus内容

|      功能参数       | 是否必要 |     类型      | 备注                                     |
| :-----------------: | :------: | :-----------: | ---------------------------------------- |
|       builder       |   true   | WidgetBuilder | 下拉内容                                 |
|    screenHeight     |  false   |    double     | 最大高度,默认屏幕高度,自动计算时必须填写 |
|    draughtHeight    |   true   |    double     | 内容高度,                                |
| bottomSpacingHeight |  false   |    double     | 距离屏幕底部高度,自动计算时必须填写      |

***单选图片功能详解***

|   功能   | 实现功能                                 | 内容                                                         |
| :------: | :--------------------------------------- | :----------------------------------------------------------- |
| 交易类型 | 单选选中,不提供title变色,不提供title更改 | 条件:剔除元数据title字段                                     |
|   范围   | 单选选中,提供title变色,不提供title更改   | 条件:添加元数据title字段,将header下标放入specialModules,开启selectIsChangingColor |
|   排序   | 单选选中,提供title变色,提供title更改     | 条件:添加元数据title字段,禁止将header下标放入specialModules,开启selectIsChangingColor |

![示例图2](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown2.gif "示例图2")

***DropdownListMenu***

> 多功能tempalte,单选+多选+自定义按钮+自定义输入



|     功能参数      | 是否必要 |       类型       | 备注                                                         |
| :---------------: | :------: | :--------------: | ------------------------------------------------------------ |
|   selectedIndex   |  false   |      Object      | 默认选中                                                     |
| isOperatingButton |  false   |       bool       | 是否需要按钮                                                 |
|   isCustomInput   |  false   |       bool       | 是否需要自定义输入                                           |
|    customInput    |  false   | CustomInputClass | 定义自定义输入回显值的key与输入框HintText                    |
|     keyWords      |   true   |      String      | 数据是否重复判断依据                                         |
|     valueKey      |  false   |      String      | 当元数据没有title字段时,显示内容的key需要传入\|也可以自定义itemBuilder内容 |
|    isMultiple     |  false   |       bool       | 是否多选                                                     |
|       data        |   true   |   List<Object>   | 元数据内容                                                   |
|    itemBuilder    |   true   | MenuItemBuilder  | 展示item布局,可自定义                                        |



| 功能实现 |          实现功能          | 内容 |
| :------: | :------------------------: | :--- |
| 交易金额 | 多选+自定义输入+自定义按钮 | 看图 |
|   范围   |            多选            | 看图 |
|   排序   |      多选+自定义按钮       | 看图 |

![示例图3](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown3.gif "示例图3")

***DropdownMenuCustomize***

> 功能：自定义下拉内容



|  功能参数   | 是否必要 |         类型         | 备注         |
| :---------: | :------: | :------------------: | ------------ |
|    data     |  false   |       List<T>        | 传入内容     |
| itemBuilder |   true   | BlankMenuItemBuilder | 内容整个布局 |

> 额外使用功能:
>
> ```flutter
> DropdownMenuController controller; 控制显示关闭,可以配合WillPopScope返回时监听是否关闭并进行关闭之后再进行页面退出
>
>  onWillPop: () async{
>           if(controller == null || controller.event == DropdownEvent.HIDE){
>             Navigator.pop(context);
>           }
>           controller.hide();
>           return;
>         }
>
> GlobalKey _globalKey;获取context,必须有变化的组件下,绝对布局或者滚动,需要获取绝对布局的context
> ScrollController scrollController;控制动画的
> ```
>
> ```
> controller.assignment({'title': '更多---'}, menuIndex);///自定义内容时没有用到select传输数据可以由次方法重新更改title
> ```

![示例图4](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown4.gif "示例图4")

**贴段代码吧**

```dart
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
                    '交易类型筛选：单选,不提供选中头部回显,在元数据中剔除title字段即可 \n\n范围筛选：单选，不提供选中头部回显，但是提供选中头部颜色更改，使用specialModules属性标注，\n\n排序类型筛选：单选，提供选中内容头部回显不剔除title字段，设置selectIsChangingColor属性',
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
      titles: ['交易类型','范围','排序'],
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
                  selectedIndex:  FilterData.housingTypes[0],
                  isOperatingButton : false,
                  keyWords : "key",
                  data: FilterData.housingTypes,
                  valueKey: 'value',
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
                  selectedIndex:  FilterData.ranges[0],
                  isOperatingButton : false,
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
                  isOperatingButton : false,
                  keyWords : "key",
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

```

# flutter_custom_dropdown

> 创建命令

```dart
flutter create --org com.example --template=plugin --platforms=android,ios -a java -i objc flutter_custom_dropdown
```

**本组件由Github作者[best-flutter](https://github.com/best-flutter)插件[flutter_dropdown_menu](https://github.com/best-flutter/flutter_dropdown_menu)更改而来,由于更新问题,以及使用上不满足业务问题自己修改了相关bug做了更新迭代,所以重新集成为新插件**



![示例图1](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown1.gif "示例图1")

***DefaultDropdownMenuController***

> 功能：包裹页面提供默认Controller

|  功能参数  | 是否必要 |  类型  | 备注                                          |
| :--------: | :------: | :----: | :-------------------------------------------- |
| onSelected |   true   |  bool  | 选中时，触发controller.selected时会回调此方法 |
|   child    |   true   | widget | 包裹内容                                      |

***DropdownHeader***

> 功能：下拉头部模块

|       功能参数        | 是否必要 |     类型     | 备注                                                         |
| :-------------------: | :------: | :----------: | :----------------------------------------------------------- |
|      isSideline       |  false   |     bool     | 是否需要分割线                                               |
|         onTap         |  false   |     func     | 触发头部回调,内部自动提供,自定义头部事件需自定义             |
|        titles         |   true   | List<String> | 头部显示title列表                                            |
| selectIsChangingColor |  false   |     bool     | 选中是否更改回显title字段可specialModules联合使用            |
|    specialModules     |  false   |  List<int>   | 选中是否只改变title颜色不更改title文字,此功能selectIsChangingColor必须为true,权重大于selectIsChangingColor功能 |

***DropdownMenu***

> 功能：悬停筛选模块

|   功能参数    | 是否必要 |              类型               | 备注                                       |
| :-----------: | :------: | :-----------------------------: | ------------------------------------------ |
|     menus     |   true   |    List<DropdownMenuBuilder>    | list长度必须与titles长度一致               |
| packUpHeight  |  false   |             double              | 收起长度不够时可自行添加                   |
| hideDuration  |  false   |            Duration             | 收起时自定义时长                           |
| showDuration  |  false   |            Duration             | 展开时自定义时长                           |
|   showCurve   |  false   |              Curve              | 自定义动画                                 |
|   hideCurve   |  false   |              Curve              | 自定义动画                                 |
|     blur      |  false   |             double              | 蒙层透明值                                 |
|    onHide     |  false   |          VoidCallback           | 蒙层触发操作回调                           |
|  switchStyle  |  false   | DropdownMenuShowHideSwitchStyle | 菜单样式                                   |
| maxMenuHeight |  false   |             double              | 最大高度,未提供自动计算时,需要指定最大高度 |

***DropdownMenuBuilder***

> 功能：menus内容

|      功能参数       | 是否必要 |     类型      | 备注                                     |
| :-----------------: | :------: | :-----------: | ---------------------------------------- |
|       builder       |   true   | WidgetBuilder | 下拉内容                                 |
|    screenHeight     |  false   |    double     | 最大高度,默认屏幕高度,自动计算时必须填写 |
|    draughtHeight    |   true   |    double     | 内容高度,                                |
| bottomSpacingHeight |  false   |    double     | 距离屏幕底部高度,自动计算时必须填写      |

***单选图片功能详解***

|   功能   | 实现功能                                 | 内容                                                         |
| :------: | :--------------------------------------- | :----------------------------------------------------------- |
| 交易类型 | 单选选中,不提供title变色,不提供title更改 | 条件:剔除元数据title字段                                     |
|   范围   | 单选选中,提供title变色,不提供title更改   | 条件:添加元数据title字段,将header下标放入specialModules,开启selectIsChangingColor |
|   排序   | 单选选中,提供title变色,提供title更改     | 条件:添加元数据title字段,禁止将header下标放入specialModules,开启selectIsChangingColor |

![示例图2](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown2.gif "示例图2")

***DropdownListMenu***

> 多功能tempalte,单选+多选+自定义按钮+自定义输入



|     功能参数      | 是否必要 |       类型       | 备注                                                         |
| :---------------: | :------: | :--------------: | ------------------------------------------------------------ |
|   selectedIndex   |  false   |      Object      | 默认选中                                                     |
| isOperatingButton |  false   |       bool       | 是否需要按钮                                                 |
|   isCustomInput   |  false   |       bool       | 是否需要自定义输入                                           |
|    customInput    |  false   | CustomInputClass | 定义自定义输入回显值的key与输入框HintText                    |
|     keyWords      |   true   |      String      | 数据是否重复判断依据                                         |
|     valueKey      |  false   |      String      | 当元数据没有title字段时,显示内容的key需要传入\|也可以自定义itemBuilder内容 |
|    isMultiple     |  false   |       bool       | 是否多选                                                     |
|       data        |   true   |   List<Object>   | 元数据内容                                                   |
|    itemBuilder    |   true   | MenuItemBuilder  | 展示item布局,可自定义                                        |



| 功能实现 |          实现功能          | 内容 |
| :------: | :------------------------: | :--- |
| 交易金额 | 多选+自定义输入+自定义按钮 | 看图 |
|   范围   |            多选            | 看图 |
|   排序   |      多选+自定义按钮       | 看图 |

![示例图3](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown3.gif "示例图3")

***DropdownMenuCustomize***

> 功能：自定义下拉内容



|  功能参数   | 是否必要 |         类型         | 备注         |
| :---------: | :------: | :------------------: | ------------ |
|    data     |  false   |       List<T>        | 传入内容     |
| itemBuilder |   true   | BlankMenuItemBuilder | 内容整个布局 |

> 额外使用功能:
>
> ```flutter
> DropdownMenuController controller; 控制显示关闭,可以配合WillPopScope返回时监听是否关闭并进行关闭之后再进行页面退出
>
>  onWillPop: () async{
>           if(controller == null || controller.event == DropdownEvent.HIDE){
>             Navigator.pop(context);
>           }
>           controller.hide();
>           return;
>         }
>
> GlobalKey _globalKey;获取context,必须有变化的组件下,绝对布局或者滚动,需要获取绝对布局的context
> ScrollController scrollController;控制动画的
> ```
>
> ```
> controller.assignment({'title': '更多---'}, menuIndex);///自定义内容时没有用到select传输数据可以由次方法重新更改title
> ```

![示例图4](https://github.com/Quietly-20201113/PictureSpace/blob/main/flutter_cunstimize_dropdown/cunstumize_dropdown4.gif "示例图4")

**贴段代码吧**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cunstimize_dropdown/flutter_cunstomize_dropdown.dart';
import 'package:flutter_cunstimize_dropdown_example/config/filter_data.dart';
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
                    '交易类型筛选：单选,不提供选中头部回显,在元数据中剔除title字段即可 \n\n范围筛选：单选，不提供选中头部回显，但是提供选中头部颜色更改，使用specialModules属性标注，\n\n排序类型筛选：单选，提供选中内容头部回显不剔除title字段，设置selectIsChangingColor属性',
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
      titles: ['交易类型','范围','排序'],
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
                  selectedIndex:  FilterData.housingTypes[0],
                  isOperatingButton : false,
                  keyWords : "key",
                  data: FilterData.housingTypes,
                  valueKey: 'value',
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
                  selectedIndex:  FilterData.ranges[0],
                  isOperatingButton : false,
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
                  isOperatingButton : false,
                  keyWords : "key",
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

```

