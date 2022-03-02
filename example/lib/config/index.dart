import 'package:flutter/material.dart';

final Color _fontColor = const Color(0XFFC0C4CC);
final double _fontSize = 11;
final Color _labelBgColor = Colors.white;
GlobalKey<_LabelWidgetState> childLabelKey = GlobalKey();

class LabelWidget extends StatefulWidget {
  final Map tagItem;
  final double? fontSize;
  final Color? fontColor;
  final Widget? child;
  final List<BoxShadow> boxShadow;
  final Color? labelBgColor;
  final bool isBorder;
  final BoxBorder? border;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const LabelWidget({
    Key? key,
    this.tagItem = const {'name': '标签'},
    this.fontSize,
    this.fontColor,
    this.border,
    this.padding,
    this.isBorder = true,
    this.labelBgColor,
    this.child,
    this.borderRadius,
    this.boxShadow = const [],
    this.alignment,
  }) : super(key: key);

  @override
  _LabelWidgetState createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding ?? const EdgeInsets.only(top: .5, bottom: 2.5, left: 4, right: 4),
        alignment: widget.alignment,
        decoration: BoxDecoration(
            color: widget.labelBgColor ?? _labelBgColor,

            /// widget.labelBgColor??_labelBgColor,
            borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(2.0)),

            ///widget.borderRadius?? BorderRadius.all( Radius.circular(2.0)),
            border: widget.isBorder ? widget.border ?? Border.all(width: .5, color: const Color(0XFFC0C4CC)) : null,
            boxShadow: widget.boxShadow.length > 0 ? widget.boxShadow : []),
        child: widget.child ??
            Text(
              widget.tagItem['name'].toString(),
              style: TextStyle(color: widget.fontColor ?? _fontColor, fontSize: widget.fontSize ?? _fontSize),
            ));
  }
}
