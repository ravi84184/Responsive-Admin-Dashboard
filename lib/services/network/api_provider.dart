import 'package:dio/dio.dart';
import 'package:responsive_admin_dashboard/screens/company_page/model/company_response.dart';
import 'package:responsive_admin_dashboard/screens/order_page/model/order_response.dart';
import 'package:responsive_admin_dashboard/screens/payment_page/model/payment_response.dart';

import 'api_client/api_client.dart';
import 'api_client/model/general_response.dart';

/// api provider from which all api calls are defined & called.
class APIProviderIml {
  final Dio _dio = Dio();

  static APIProviderIml? _instance;
  late ApiClient _apiClient;

  APIProviderIml._() {
    _apiClient = ApiClient(_dio);
    print("APIProviderIml()");
  }

  /// get instance of api provider
  static Future<APIProviderIml> getInstance() async {
    if (_instance == null) {
      _instance = APIProviderIml._();
    }
    return _instance!;
  }

  /// api for login
  Future<GeneralResponse> sendOTPAPI({
    required String mobile,
  }) async {
    Response response;
    print("===== loginAPI Response Start =======");
    FormData data = FormData.fromMap({
      'action': "OTP_LOGIN",
      'mobile': mobile,
    });
    response = await _apiClient.post("/users.php", data: data);
    print("${response.data}");
    print("===== loginAPI Response End =======");
    return GeneralResponse.fromJson(response.data);
  }

  /// api for get all customer list
  Future<CompanyResponse> fetchAllCompanyList(context) async {
    Response response;
    print("===== fetchAllCustomerList Response Start =======");
    FormData data = FormData.fromMap({
      'ACTION_KEY': "COMPANY_LIST",
    });
    response = await _apiClient.post("/company_controller.php", data: data);
    print("data ${response.data}");
    print("===== fetchAllCustomerList Response End =======");
    return CompanyResponse.fromJson(response.data);
  }

  /// api for add customer
  Future<GeneralResponse> addCompany(context, map) async {
    Response response;
    print("===== addCompany Response Start =======");
    FormData data = FormData.fromMap(map);
    response = await _apiClient.post("/company_controller.php", data: data);
    print("data ${response.data}");
    print("===== addCompany Response End =======");
    return GeneralResponse.fromJson(response.data);
  }

  /// api for delete customer
  Future<GeneralResponse> deleteCustomer(context, id) async {
    Response response;
    print("===== deleteCustomer Response Start =======");
    Map<String, dynamic> map = {
      "ACTION_KEY": "DELETE_COMPANY",
      "company_id": id,
    };
    FormData data = FormData.fromMap(map);
    response = await _apiClient.post("/company_controller.php", data: data);
    print("data ${response.data}");
    print("===== deleteCustomer Response End =======");
    return GeneralResponse.fromJson(response.data);
  }

  /// api for get all customer list
  Future<OrderResponse> fetchAllOrderList(context) async {
    Response response;
    print("===== fetchAllOrderList Response Start =======");
    FormData data = FormData.fromMap({
      'ACTION_KEY': "ORDER_LIST",
    });
    response = await _apiClient.post("/order_controller.php", data: data);
    print("${response.data}");
    print("===== fetchAllOrderList Response End =======");
    return OrderResponse.fromJson(response.data);
  }

  /// api for add Order
  Future<GeneralResponse> addOrder(context, map) async {
    Response response;
    print("===== addOrder Response Start =======");
    FormData data = FormData.fromMap(map);
    response = await _apiClient.post("/order_controller.php", data: data);
    print("${response.data}");
    print("===== addOrder Response End =======");
    return GeneralResponse.fromJson(response.data);
  }

  /// api for delete Order
  Future<GeneralResponse> deleteOrder(context, id) async {
    Response response;
    print("===== deleteOrder Response Start =======");
    Map<String, dynamic> map = {
      "ACTION_KEY": "DELETE_ORDER",
      "order_id": id,
    };
    print(map);
    FormData data = FormData.fromMap(map);
    response = await _apiClient.post("/order_controller.php", data: data);
    print("${response.data}");
    print("===== deleteOrder Response End =======");
    return GeneralResponse.fromJson(response.data);
  }

  /// api for get all customer list
  Future<PaymentResponse> fetchAllPaymentList(context) async {
    Response response;
    print("===== fetchAllPaymentList Response Start =======");
    FormData data = FormData.fromMap({
      'ACTION_KEY': "PAYMENT_LIST",
    });
    response = await _apiClient.post("/payment_controller.php", data: data);
    print("${response.data}");
    print("===== fetchAllPaymentList Response End =======");
    return PaymentResponse.fromJson(response.data);
  }

  /// api for delete Payment
  Future<GeneralResponse> deletePayment(context, id) async {
    Response response;
    print("===== deletePayment Response Start =======");
    Map<String, dynamic> map = {
      "ACTION_KEY": "DELETE_PAYMENT",
      "payment_id": id,
    };
    print(map);
    FormData data = FormData.fromMap(map);
    response = await _apiClient.post("/payment_controller.php", data: data);
    print("${response.data}");
    print("===== deletePayment Response End =======");
    return GeneralResponse.fromJson(response.data);
  }

  /// api for add payment
  Future<GeneralResponse> addPayment(context, map) async {
    Response response;
    print("===== addPayment Response Start =======");
    FormData data = FormData.fromMap(map);
    response = await _apiClient.post("/payment_controller.php", data: data);
    print("${response.data}");
    print("===== addPayment Response End =======");
    return GeneralResponse.fromJson(response.data);
  }
}
