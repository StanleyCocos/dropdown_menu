import 'package:flutter/material.dart';

import 'dropdown_menu_controller.dart';

class DropDownHeader extends StatefulWidget {
  final DropdownMenuController controller;
  final void Function<T>(T value)? onItemTap;

  final GlobalKey stackKey;
  final List<Widget> children;

  const DropDownHeader({
    super.key,
    required this.children,
    required this.controller,
    required this.stackKey,
    this.onItemTap,
  });

  @override
  State<StatefulWidget> createState() => _DropDownHeaderState();
}

class _DropDownHeaderState extends State<DropDownHeader>
    with SingleTickerProviderStateMixin {
  final GlobalKey _keyDropDownHeader = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onController);
  }

  _onController() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _keyDropDownHeader,
      child: Row(
        children: widget.children
            .asMap()
            .map((index, e) {
              return MapEntry(index, _item(index, e));
            })
            .values
            .toList(),
      ),
    );
  }

  Widget _item(int index, Widget item) {
    return GestureDetector(
      onTap: () {
        int menuIndex = widget.controller.menuIndex;
        final RenderBox? overlay =
            widget.stackKey.currentContext!.findRenderObject() as RenderBox?;
        final RenderBox dropDownItemRenderBox =
            _keyDropDownHeader.currentContext!.findRenderObject() as RenderBox;

        var position =
            dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
        var size = dropDownItemRenderBox.size;

        widget.controller.dropDownMenuTop = size.height + position.dy;

        if (index == menuIndex) {
          if (widget.controller.isShow) {
            widget.controller.hide();
          } else {
            widget.controller.show(index);
          }
        } else {
          if (widget.controller.isShow) {
            widget.controller.hide(isShowHideAnimation: false);
          }
          widget.controller.show(index);
        }

        if (widget.onItemTap != null) {
          widget.onItemTap!(index);
        }

        setState(() {});
      },
      child: item,
    );
  }
}