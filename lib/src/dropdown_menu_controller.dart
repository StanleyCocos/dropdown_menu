import 'package:flutter/foundation.dart';

class DropdownMenuController extends ChangeNotifier {
  double? dropDownMenuTop;

  int menuIndex = 0;

  bool isShow = false;

  bool isShowHideAnimation = false;

  void show(int index) {
    isShow = true;
    menuIndex = index;
    notifyListeners();
  }

  void hide({bool isShowHideAnimation = true}) {
    this.isShowHideAnimation = isShowHideAnimation;
    isShow = false;
    notifyListeners();
  }
}
