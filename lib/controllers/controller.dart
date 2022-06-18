import 'package:flutter/material.dart';

enum MenuItem {
  Dashboard,
  Customer,
  Order,
  Payment,
}

class Controller extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  MenuItem selectedMenu = MenuItem.Customer;

  void changeMenu(context, MenuItem menuItem) {
    selectedMenu = menuItem;
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
