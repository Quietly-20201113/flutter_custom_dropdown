import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'drapdown_common.dart';


typedef void DropdownMenuHeadTapCallback(int index);
///头部样式
typedef String GetItemLabel(dynamic data,[String valueKey]);
///头部图标样式
typedef Widget GetCustomizeImage(bool selected,bool subjectiveSelected);
///文本显示title提取
String defaultGetItemLabel(dynamic data,[String valueKey]) {
  if (data is String) return data;
  if(data is Map){
    ///自定义显示文本字段
    if(valueKey != null){
      if(data.containsKey(valueKey)){
        if(data[valueKey] != null){
          return data[valueKey];
        }
      }
    }
    if(data.containsKey('title')){
      if(data["title"] != null){
        return data["title"];
      }
    }
  }
  if(data is List){
    ///多选情况赋值第一个
    if(data.length >= 1){
       try{
         String _title = data[0]["title"];
         if(_title.isNotEmpty){
           return _title;
         }
       }catch(err){
         return '';
       }
    }
  }
  return '';
}

class DropdownHeader extends DropdownWidget {
  final List<dynamic> titles;
  final bool selectIsChangingColor;///选中查询内容是否显示选中颜色
  final int activeIndex;
  final Color selectColor;
  final Color unselectedColor;
  final bool isSideline;///是否有边线
  final DropdownMenuHeadTapCallback onTap;
  final String dropDownImage;///未选中图标
  final String dropDownSelectImage;///选中图标
  final List<int> specialModules;///只显示不回填值
  final GetCustomizeImage imageWidget;///自定义头部图标

  /// 筛选头部高度
  final double height;

  /// 头部显示内容
  final GetItemLabel getItemLabel;

  const DropdownHeader(
      {@required this.titles,
      this.activeIndex,
      DropdownMenuController controller,
      this.onTap,
       this.selectIsChangingColor = false,
        this.selectColor,
        this.unselectedColor,
        this.specialModules = const [],
      Key key,
      this.height: 46.0,
        this.isSideline = true,
        this.dropDownSelectImage,
        this.dropDownImage,
        this.imageWidget,
      GetItemLabel getItemLabel})
      : getItemLabel = getItemLabel ?? defaultGetItemLabel,
        assert(titles != null && titles.length > 0),
        super(key: key, controller: controller);

  @override
  DropdownState<DropdownWidget> createState() {
    return new _DropdownHeaderState();
  }
}

class _DropdownHeaderState extends DropdownState<DropdownHeader> {

  bool contentSelected = false;
  Widget buildItem(
      BuildContext context, dynamic title, bool selected, int index,dynamic _title) {
    double _screenWidth = MediaQuery.of(context).size.width - 20;
    final Color primaryColor = widget.selectColor??Theme.of(context).primaryColor;
    final Color unselectedColor = widget.unselectedColor??Theme.of(context).unselectedWidgetColor;
    final GetItemLabel getItemLabel = widget.getItemLabel;
    bool _selected = false;
    dynamic _showTitle = title;
    ///选中后是否亮起
    if(widget.selectIsChangingColor){
      if(!(_title == title)){
        _selected = true;
        ///处理特殊显示问题,有些样例只需要显示颜色不需要更改头部title
        if(widget.specialModules.length > 0){
          if(widget.specialModules.contains(index)){
            _showTitle = _title;
          }
        }
      }
    }
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: DecoratedBox(
              decoration: new BoxDecoration(
                  border: widget.isSideline ? Border(left: Divider.createBorderSide(context)) :  null
              ),
              child: new Container(
                margin: const EdgeInsets.only(left: 1.0,right: 1.0),
                width: (_screenWidth / widget.titles.length)-20,
                child:Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child:Container(
                                child:  Text(
                                  getItemLabel(_showTitle),
                                  style:  TextStyle(
                                      color: _selected ? primaryColor : selected ? primaryColor : unselectedColor,
                                      fontSize: 15.0
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              )
                          ),
                          Container(width: 0.0,)
                        ],
                      ),
                    ),
                    _imageAsset(selected,_selected,primaryColor,unselectedColor)
                  ],
                ),
              ))
      ),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap(index);
          return;
        }
        if (controller != null) {
          if (_activeIndex == index) {
            controller.hide();
            setState(() {
              _activeIndex = null;
            });
          } else {
            if(_activeIndex != null){
              controller.hide();
              ////TODO : 延时处理show时蒙层刚关闭没反应过来
              Future.delayed(const Duration(milliseconds: 250), () {
                controller.show(index);
              });
              return;
            }
            controller.show(index);
          }
        }
        //widget.onTap(index);
      },
    );
  }

  ///处理图标
  Widget _imageAsset(bool selected,bool _selected,Color primaryColor,Color unselectedColor ){
    if(widget.imageWidget != null){
      return widget.imageWidget(selected,_selected);
    }
    if(widget.dropDownImage == null || widget.dropDownSelectImage == null){
      return Icon(
        selected ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        color: _selected ? primaryColor : selected ? primaryColor : unselectedColor,
      );
    }
    return Image.asset(selected ? widget.dropDownSelectImage: widget.dropDownImage,width: 18.0,height: 18.0,color: _selected ? primaryColor : selected  ? primaryColor : unselectedColor,);
  }

  int _activeIndex;///选中菜单index
  List<dynamic> _titles;///头部重新赋值
  List<dynamic> _titlesCopy; /// 保留原始头部值

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    final int activeIndex = _activeIndex;
    final List<dynamic> titles = _titles;
    final double height = widget.height;
    for (int i = 0, c = widget.titles.length; i < c; ++i) {
      list.add(buildItem(context, titles[i], i == activeIndex, i,_titlesCopy[i]));
    }

    list = list.map((Widget widget) {
      return new Expanded(
        child: widget,
      );
    }).toList();

    final Decoration decoration = new BoxDecoration(
      border: new Border(
        bottom: Divider.createBorderSide(context),
      ),
    );

    return new DecoratedBox(
      decoration: decoration,
      child: new SizedBox(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: list,
          ),
          height: height),
    );
  }

  @override
  void initState() {
    _titles = widget.titles;
    _titlesCopy = []..addAll(widget.titles);
    super.initState();
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
        {
          setState(() {
            _activeIndex = null;
            String label = widget.getItemLabel(controller.data);
            try{
              _titles[controller.menuIndex] = label == "" ? _titles[controller.menuIndex] : label;
            }catch(err){

            }
          });
        }
        break;
      case DropdownEvent.HIDE:
        {
          print('选中内容HIDE = ${controller.data}');
          if (_activeIndex == null) return;
          setState(() {
            _activeIndex = null;
          });
        }
        break;
      case DropdownEvent.ACTIVE:
        {
          if (_activeIndex == controller.menuIndex) return;
          setState(() {
            _activeIndex = controller.menuIndex;
          });
        }
        break;
    }
  }
}
