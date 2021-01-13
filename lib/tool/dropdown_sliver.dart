import 'package:flutter/material.dart';
/// TODO : 特殊滚动页面自定义头部
/// TODO : 例子 : 滚动后停止
/// @param
/// @return
/// created at 2021/1/11 11:58
///
class DropdownSliverChildBuilderDelegate
    extends SliverPersistentHeaderDelegate {
  final WidgetBuilder builder;
  final double maxDefinitionExtent;
  final double minDefinitionExtent;

 const DropdownSliverChildBuilderDelegate({this.builder,this.maxDefinitionExtent, this.minDefinitionExtent,}) : assert(builder != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context);
  }

  // TODO: implement maxExtent
  @override
  double get maxExtent => this.maxDefinitionExtent??46.0;

  // TODO: implement minExtent
  @override
  double get minExtent => this.minDefinitionExtent??46.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
