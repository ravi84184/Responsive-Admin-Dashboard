import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_admin_dashboard/common/app_loading.dart';
import 'package:responsive_admin_dashboard/screens/company_page/model/company_response.dart';
import 'package:responsive_admin_dashboard/services/network/api_provider.dart';

class CompanyController with ChangeNotifier {
  APIProviderIml _apiProviderIml = GetIt.I.get<APIProviderIml>();
  List<CompanyPayload>? companyList;

  Future<void> addCompany(context, Map<String, dynamic> map) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.addCompany(context, map);
      if (result.error.code == 200) {
        Navigator.pop(context, true);
        notifyListeners();
      } else {
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("addCompany ${e.toString()}");
    }
  }

  void updateCompany(context, id) {}

  Future<void> getCompanyList(context) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.fetchAllCompanyList(context);
      if (result.error.code == 200) {
        companyList = result.payload;
        notifyListeners();
      } else {
        companyList = [];
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("getCustomerList ${e.toString()}");
    }
  }

  Future<void> deleteCustomer(context, id) async {
    AppLoading.showLoadingDialog(context);
    try {
      var result = await _apiProviderIml.deleteCustomer(context, id);
      if (result.error.code == 200) {
        companyList!.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        notifyListeners();
      }
      AppLoading.closeLoadingDialog();
    } catch (e) {
      AppLoading.closeLoadingDialog();
      print("deleteCustomer ${e.toString()}");
    }
  }

  void getCustomerDetails(context, id) {}
}
