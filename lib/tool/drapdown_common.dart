import 'package:flutter/widgets.dart';

enum DropdownEvent {
  // 关闭
  HIDE,

  // 打开
  ACTIVE,

  // 传输数据
  SELECT
}

class DropdownMenuController extends ChangeNotifier {
  ///下拉状态
  DropdownEvent event = DropdownEvent.HIDE;

  ///当前操作下标
  int menuIndex = -1;

  /// 选中内容
  dynamic data;

  void hide() {
    event = DropdownEvent.HIDE;
    notifyListeners();
  }

  void show(int index) {
    event = DropdownEvent.ACTIVE;
    menuIndex = index;
    notifyListeners();
  }

  ///自定义赋值
  void select(dynamic _data, [int? index]) {
    event = DropdownEvent.SELECT;
    this.data = _data;
    if (index != null) {
      this.menuIndex = index;
    }
    notifyListeners();
  }

  ///单纯的赋值,不做操作,适用于非弹出页面,复杂模块赋值
  void assignment(dynamic _data, [int? index]) {
    this.data = _data;
    if (index != null) {
      this.menuIndex = index;
    }
  }
}

typedef DropdownMenuOnSelected({int menuIndex, dynamic data});

class DefaultDropdownMenuController extends StatefulWidget {
  const DefaultDropdownMenuController({
    Key? key,
    required this.child,
    this.onSelected,
  }) : super(key: key);

  final Widget child;

  final DropdownMenuOnSelected? onSelected;

  static DropdownMenuController? of(BuildContext context) {
    final _DropdownMenuControllerScope? scope = context.dependOnInheritedWidgetOfExactType<_DropdownMenuControllerScope>();
    return scope?.controller;
  }

  @override
  _DefaultDropdownMenuControllerState createState() => new _DefaultDropdownMenuControllerState();
}

class _DefaultDropdownMenuControllerState extends State<DefaultDropdownMenuController> with SingleTickerProviderStateMixin {
  late DropdownMenuController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new DropdownMenuController();
    _controller.addListener(_onController);
  }

  void _onController() {
    switch (_controller.event) {
      case DropdownEvent.SELECT:
        {
          //通知widget
          if (widget.onSelected == null) return;
          widget.onSelected!(
            data: _controller.data,
            menuIndex: _controller.menuIndex,
          );
        }
        break;
      case DropdownEvent.ACTIVE:
        break;
      case DropdownEvent.HIDE:
        break;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onController);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DropdownMenuControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }
}

class _DropdownMenuControllerScope extends InheritedWidget {
  const _DropdownMenuControllerScope({Key? key, this.controller, required this.enabled, required Widget child}) : super(key: key, child: child);

  final DropdownMenuController? controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_DropdownMenuControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}

abstract class DropdownWidget extends StatefulWidget {
  final DropdownMenuController? controller;

  const DropdownWidget({Key? key, this.controller}) : super(key: key);

  @override
  DropdownState<DropdownWidget> createState();
}

abstract class DropdownState<T extends DropdownWidget> extends State<T> {
  DropdownMenuController? controller;

  @override
  void dispose() {
    if (controller != null) {
      controller!.removeListener(_onController);
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (controller == null) {
      if (widget.controller == null) {
        controller = DefaultDropdownMenuController.of(context);
      } else {
        controller = widget.controller;
      }

      if (controller != null) {
        controller!.addListener(_onController);
      }
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    if (widget.controller != null) {
      if (controller != null) {
        controller!.removeListener(_onController);
      }
      controller = widget.controller;
      controller!.addListener(_onController);
    }

    super.didUpdateWidget(oldWidget);
  }

  void _onController() {
    onEvent(controller!.event);
  }

  void onEvent(DropdownEvent event);
}

class DropdownMenuBuilder {
  final WidgetBuilder builder;

  /* *
   * 计算高度
   * TODO : 例子60 * 6.66;[6行][每行6.66高]
   */
  final double draughtHeight;

  ///手机高度
  final double? screenHeight;

  /* *
   * 距离底部间距
   */
  final double bottomSpacingHeight;

  ///计算出的高度
  final double height;

  /* *
   *  TODO : height =  (screenHeight != null && screenHeight > 0.0) ? ((screenHeight - bottomSpacingHeight) > draughtHeight) ? draughtHeight : (screenHeight - bottomSpacingHeight) : draughtHeight;
   *  TODO : 计算高度
   *  TODO : 如果给了屏幕高度screenHeight以及距离底部高度则进行计算
   *  TODO : 屏幕高度减去距离底部高度,对比计算高度,取出最小的做高度使用
   */
  //if height == null , use [DropdownMenu.maxMenuHeight]
  const DropdownMenuBuilder({required this.builder, required this.draughtHeight, this.screenHeight, this.bottomSpacingHeight = 0.0})
      : height = (screenHeight != null && screenHeight != 0.0 && screenHeight > 0.0)
            ? ((screenHeight - bottomSpacingHeight) > draughtHeight)
                ? draughtHeight
                : (screenHeight - bottomSpacingHeight)
            : draughtHeight;
}
