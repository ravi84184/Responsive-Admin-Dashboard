import 'dart:convert';

import 'package:hive/hive.dart';

import 'hive_keys.dart';

/// prefbox class used to store & get data locally in device
class PrefBox {
  static PrefBox? _instance;
  static Box? box;

  final String _keyIsLogin = "is_login";
  final String _keyUser = "user";

  static const keyDevicePixelRatio = "device_pixel_ratio";

  static Future<PrefBox> getInstance() async {
    _instance ??= PrefBox();

    if (!Hive.isBoxOpen(HiveKeys.prefBoxName)) {
      box = await Hive.openBox(HiveKeys.prefBoxName);
    } else {
      box = Hive.box(HiveKeys.prefBoxName);
    }

    return _instance!;
  }

  bool get isLogin {
    return box!.get(_keyIsLogin) ?? false;
  }

  set isLogin(bool flag) {
    box!.put(_keyIsLogin, flag);
  }

  String get user {
    return box!.get(_keyUser) ?? "";
  }

  String get userName {
    if (box!.get(_keyUser) != null) {
      return jsonDecode(box!.get(_keyUser))['name'];
    }
    return "";
  }

  String get about {
    if (box!.get(_keyUser) != null) {
      return jsonDecode(box!.get(_keyUser))['about'];
    }
    return "";
  }

  String get userImage {
    try {
      if (user != "") {
        return jsonDecode(user)['profile'];
      }
    } catch (e) {
      return "";
    }
    return "";
  }

  set user(String flag) {
    box!.put(_keyUser, flag);
  }

  void clearLogin() {
    isLogin = false;
    user = "";
  }

  String get(key) {
    return box!.get(key) ?? "";
  }

  void add(String key, String flag) {
    box!.put(key, flag);
  }
}
