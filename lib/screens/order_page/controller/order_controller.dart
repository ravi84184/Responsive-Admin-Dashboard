import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_admin_dashboard/common/app_loading.dart';
import 'package:responsive_admin_dashboard/screens/order_page/model/order_response.dart';
import 'package:responsive_admin_dashboard/services/network/api_provider.dart';

class OrderController with ChangeNotifier {
  APIProviderIml _apiProviderIml = GetIt.I.get<APIProviderIml>();
  List<OrderPayload>? orderList;

  Future<void> addOrder(context, Map<String, String> map) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.addOrder(context, map);
      if (result.error.code == 200) {
        Navigator.pop(context, true);
        notifyListeners();
      } else {
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("addOrder ${e.toString()}");
    }
  }

  void updateOrder(context, id) {}

  Future<void> getOrderList(context) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.fetchAllOrderList(context);
      if (result.error.code == 200) {
        orderList = result.payload;
        notifyListeners();
      } else {
        orderList = [];
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("getOrderList ${e.toString()}");
    }
  }

  Future<void> deleteOrder(context, id) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.deleteOrder(context,id);
      if (result.error.code == 200) {
        orderList!.removeWhere((element) => element.orderId == id);
        notifyListeners();
      } else {
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("getOrderList ${e.toString()}");
    }
  }

  void getOrderDetails(context, id) {}
}
