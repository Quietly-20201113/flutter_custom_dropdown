import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'drapdown_common.dart';
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';
typedef Widget MenuItemBuilder<T>(
    BuildContext context, T data, bool selected,String valueKey);
///自定义按钮,重置按钮,确定按钮,选中数据,自定义处置通知按钮
typedef Widget MenuButtonBuilder(BuildContext context,Object data,{VoidCallback resetOnTap,VoidCallback fixOnTap,VoidCallback noticeOnTap});

class CustomInputClass{
     final String startInput;///开始输入内容
     final String endInput;///结束输入内容
     final String startHintText;///开始展示提示
     final String endHintText;///结束框展示提示
     final TextInputType keyboardType;///输入格式
     const CustomInputClass({this.startInput = 'startInput',this.endInput = 'endInput',this.startHintText = '',this.endHintText = '',this.keyboardType});
  }


class DropdownListMenu<T> extends DropdownWidget {
  final List<T> data;
  final dynamic keyWords;///作为判断依据的key
  final String valueKey;///显示内容的key
  final bool isOperatingButton;///是否包含按钮
  final dynamic selectedIndex;///初始化选中数据
  final MenuItemBuilder itemBuilder;
  final MenuButtonBuilder buttonBuilder;///自定义按钮
  final bool isCustomInput;///是否自定义输入
  final bool isMultiple;///是否多选
  final CustomInputClass customInput;///定义输入文本格式字段key
  const DropdownListMenu({
    @required this.keyWords,
    @required this.data,
    this.isOperatingButton = true,
    this.isCustomInput = false,
    this.buttonBuilder,
    this.valueKey,
    this.customInput,
    this.isMultiple = false,
    this.selectedIndex,
    this.itemBuilder,
  });

  @override
  DropdownState<DropdownWidget> createState() {
    return new _MenuListState<T>();
  }
}

class _MenuListState<T> extends DropdownState<DropdownListMenu<T>> {
  dynamic _selectedIndex;
  bool _isMultiple = false;
  bool _isCustomInput = false;
  String minPrince = "";
  String maxPrince = "";
  Map princes = {};
  List<dynamic>  _superclassIndex = [];

  ///传出给父类最最终值
  List<dynamic> _subclassIndex = [];

  ///子类操作值
  bool isRegular = false;

  @override
  void initState() {
    _isCustomInput = widget.isCustomInput;
    _subclassIndex = [widget.selectedIndex];
    _selectedIndex = widget.selectedIndex;
    _isMultiple = widget.isMultiple;
    princes[widget.customInput?.startInput??'value1'] = null;
    princes[widget.customInput?.endInput??'value2'] = null;
    super.initState();
  }

  bool _contains(dynamic element, List<dynamic> list) {
    ///判断是否相同
    for (var i = 0; i < list.length; i++) {
      if (list[i][widget.keyWords] == element[widget.keyWords]) {
        return true;
      }
    }
    return false;
  }

  Widget buildItem(BuildContext context, int index) {
    final List<T> list = widget.data;
    final T data = list[index];
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          color: const Color(0XFFFFFFFF),
          child: widget.itemBuilder(
              context, data, _contains(data, _subclassIndex),widget.valueKey),),
      onTap: () {
        isRegular = true;
        FocusScope.of(context).requestFocus(FocusNode());
        _dealingMultiple(data);
      },
    );
  }

  void _dealingMultiple(dynamic data) {
    setState(() {
      if (!_contains(data, _subclassIndex)) {
        ///处理多选与单选问题
        if (!_isMultiple ||
            data[widget.keyWords] == _selectedIndex[widget.keyWords]) {
          _subclassIndex.clear();
          if(!_isMultiple){
            _superclassIndex.clear();
            _superclassIndex.add(data);
            _subclassIndex.add(data);
            assert(controller != null);
            controller.select(_subclassIndex);
          }
        }
        if (_isMultiple &&
            data[widget.keyWords] != _selectedIndex[widget.keyWords]) {
          if (_contains(_selectedIndex, _subclassIndex)) {
            _subclassIndex.remove(_selectedIndex);
            _subclassIndex.clear();
          }
        }
        _subclassIndex.add(data);
      } else {
        if (_isMultiple) {
          _subclassIndex.remove(data);
        }
      }
      minPrince = "";
      maxPrince = "";
      if (_subclassIndex.length == 0) _subclassIndex.add(_selectedIndex);
    });
    if(widget.isMultiple && !widget.isOperatingButton){
      _superclassIndex = []..addAll(_subclassIndex);
      assert(controller != null);
      controller.select( _superclassIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color:const Color(0XFFFFFFFF),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: _isCustomInput
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextField(
                                  inputFormatters: [
                                    // ignore: deprecated_member_use
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType:  widget.customInput?.keyboardType == TextInputType.number ? const TextInputType.numberWithOptions(decimal: true) : widget.customInput?.keyboardType??TextInputType.text,
                                  autofocus: false,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: const TextStyle(
                                        color: Color(0XFFC0C4CC),
                                        fontSize: 18.0),
                                    hintText: "${widget.customInput?.startHintText??''}",
                                  ),
                                  //使用controller保存输入框的值
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: minPrince.toString(),
                                          selection:
                                          new TextSelection.fromPosition(
                                              TextPosition(
                                                  affinity: TextAffinity
                                                      .downstream,
                                                  offset: minPrince
                                                      .toString()
                                                      .length)))),

                                  onChanged: (text) {
                                    setState(() {
                                      minPrince = text;
//                                      princes['minPrince'] = minPrince;
                                      princes[widget.customInput?.startInput??'value1'] = minPrince;
                                      if(minPrince == '' && maxPrince == ''){
                                        _subclassIndex.add(_selectedIndex);
                                      }else{
                                        _subclassIndex.clear();
                                        _subclassIndex.remove(_selectedIndex);
                                      }
                                    });
                                  },
                                  onSubmitted: (text) {
//                                    setState(() {
//                                      minPrince = text;
//
////                                      princes['minPrince'] = minPrince;
//                                      _subclassIndex.remove(_selectedIndex);
//                                    });
                                  },
                                ),
                              ),
                              const Divider(
                                height: .5,
                                color: Color(0XFF909399),
                              )
                            ],
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 11.0),
                      child: const Text(
                        "至",
                        style: TextStyle(
                            color: Color(0XFF606266),
                            fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextField(
                                  inputFormatters: [
                                    // ignore: deprecated_member_use
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: widget.customInput?.keyboardType == TextInputType.number ? const TextInputType.numberWithOptions(decimal: true) : widget.customInput?.keyboardType??TextInputType.text,
                                  autofocus: false,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "${widget.customInput?.endHintText??''}",
                                      hintStyle: const TextStyle(
                                          color: Color(0XFFC0C4CC),
                                          fontSize: 18.0)),
                                  //使用controller保存输入框的值
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: maxPrince.toString(),
                                          selection:
                                          new TextSelection.fromPosition(
                                              TextPosition(
                                                  affinity: TextAffinity
                                                      .downstream,
                                                  offset: maxPrince
                                                      .toString()
                                                      .length)))),
                                  onChanged: (text) {
                                    setState(() {
                                      maxPrince = text;
                                      princes[widget.customInput?.endInput??'value2'] = maxPrince;
                                      if(minPrince == '' && maxPrince == ''){
                                        print("${minPrince == ''}||minPrince$minPrince,maxPrince$maxPrince ===${maxPrince == ''}");
                                        _subclassIndex.add(_selectedIndex);
                                      }else{
                                        _subclassIndex.clear();
                                        _subclassIndex.remove(_selectedIndex);
                                      }
                                    });
                                  },
                                  onSubmitted: (text) {
//                                    setState(() {
//                                      maxPrince = text;
//                                      princes[widget.customInput.endInput??'value2'] = maxPrince;
//                                      _subclassIndex.remove(_selectedIndex);
//                                    });
                                  },
                                ),
                              ),
                              const Divider(
                                height: .5,
                                color: Color(0XFF909399),
                              )
                            ],
                          ),
                        )),
                  ],
                )
                    : Container(),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemExtent:50.0,
                  itemBuilder: buildItem,
                  itemCount: widget.data.length,
                ),
              ),
              _button(context)
            ],
          ),
        ));
  }

  Widget _button(BuildContext context){
    if(widget.isOperatingButton){
      if(widget.buttonBuilder == null){
        return FilterButton(
          resetOnTap: () {
            _getResetOnTap();
          },
          fixOnTap: () {
            _getFixOnTap();
          },
        );
      }
      Map _item = {widget.customInput?.startInput??'value1' : minPrince,widget.customInput?.endInput??'value2' : maxPrince};
      List _list = []..addAll(_subclassIndex);
      _list.add(_item);
      return widget.buttonBuilder(
          context,
          _list,
          fixOnTap : (){
            _getFixOnTap();
          },
          resetOnTap : (){
            _getResetOnTap();
          },
          noticeOnTap : (){
            assert(controller != null);
            controller.hide();
          }
      );
    }
    return const SizedBox(height: 0.0,);
  }

  void _getFixOnTap(){
    FocusScope.of(context).requestFocus(FocusNode());
    isRegular = false;
    setState(() {
      ///赋值深拷贝，防止清除_subclassIndex时影响_superclassIndex，两种方式
//                         _superclassIndex = json.decode(json.encode(_subclassIndex));///此方式影响性能
      princes[widget.customInput?.startInput??'value1'] = minPrince;
      princes[widget.customInput?.endInput??'value2'] = maxPrince;
      _superclassIndex = []..addAll(_subclassIndex);
      _superclassIndex.add(princes);
    });
    assert(controller != null);
    controller.select( _superclassIndex);
  }

  void _getResetOnTap(){
    isRegular = true;
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _subclassIndex.clear();
      _subclassIndex.add(_selectedIndex);
      maxPrince = "";
      minPrince = "";
    });
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
      case DropdownEvent.HIDE:
        setState(() {
          if(_subclassIndex != _superclassIndex){
            minPrince =  princes[widget.customInput?.startInput??'value1'];
            maxPrince = princes[widget.customInput?.endInput??'value2'];
            if(_superclassIndex.length == 0)_superclassIndex.add(_selectedIndex);
            _subclassIndex = []..addAll(_superclassIndex);
          }
//          if(isRegular){
//            if(_subclassIndex != _superclassIndex){
//              if(_superclassIndex.length == 0)_superclassIndex.add(_selectedIndex);
//              _subclassIndex = []..addAll(_superclassIndex);
//            }
//          }
        });
        {}
        break;
      case DropdownEvent.ACTIVE:
        {}
        break;
    }
  }
}
