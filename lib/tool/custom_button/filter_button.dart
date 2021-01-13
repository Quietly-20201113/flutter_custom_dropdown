import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///定义多选或者特殊操作时按钮
class FilterButton extends StatelessWidget {
  final VoidCallback resetOnTap;///重置
  final VoidCallback fixOnTap;///确定
  const FilterButton({Key key, @required this.resetOnTap, @required this.fixOnTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                assert(this.resetOnTap != null);
                this.resetOnTap();
              },
              child: Container(
                  alignment : Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 41.5),
                  decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius:const BorderRadius.all( Radius.circular(2.0)),
                      border:Border.all(width: .5, color: Theme.of(context).primaryColor),
                  ),
                  child: Text(
                    '重置',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18
                    ),
                  ))
              )
            ),
          const SizedBox(width: 12.0,),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                assert(this.fixOnTap != null);
                this.fixOnTap();
              },
              child:  Container(
                  alignment : Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 41.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:const BorderRadius.all( Radius.circular(2.0)),
                  ),
                  child: Text(
                    '确定',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ))
            ),
          )
        ],
      ),
    );
  }
}
