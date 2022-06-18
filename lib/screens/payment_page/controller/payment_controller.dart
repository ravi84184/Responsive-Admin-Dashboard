import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_admin_dashboard/common/app_loading.dart';
import 'package:responsive_admin_dashboard/screens/payment_page/model/payment_response.dart';
import 'package:responsive_admin_dashboard/services/network/api_provider.dart';

class PaymentController with ChangeNotifier {
  APIProviderIml _apiProviderIml = GetIt.I.get<APIProviderIml>();
  List<PaymentPayload>? paymentList;

  Future<void> addPayment(context, Map<String, String> map) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.addPayment(context, map);
      if (result.error.code == 200) {
        Navigator.pop(context, true);
        notifyListeners();
      } else {
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("getCustomerList ${e.toString()}");
    }
  }

  void updatePayment(context, id) {}

  Future<void> getPaymentList(context) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.fetchAllPaymentList(context);
      if (result.error.code == 200) {
        paymentList = result.payload;
        notifyListeners();
      } else {
        paymentList = [];
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("getPaymentList ${e.toString()}");
    }
  }

  Future<void> deletePayment(context, id) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.deletePayment(context, id);
      if (result.error.code == 200) {
        paymentList!.removeWhere((element) => element.paymentId == id);
        notifyListeners();
      } else {
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("getPaymentList ${e.toString()}");
    }
  }

  void getPaymentDetails(context, id) {}
}
