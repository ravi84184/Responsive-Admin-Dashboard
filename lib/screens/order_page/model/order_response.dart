import 'package:responsive_admin_dashboard/services/network/api_client/model/common_response.dart';

class OrderResponse extends CommonResponse {
  late List<OrderPayload> payload;

  OrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      payload = <OrderPayload>[];
      json['payload'].forEach((v) {
        payload.add(new OrderPayload.fromJson(v));
      });
    }
    error = (json['error'] != null ? new Error.fromJson(json['error']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payload != null) {
      data['payload'] = this.payload.map((v) => v.toJson()).toList();
    }
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class OrderPayload {
  late String orderId;
  late String companyId;
  late String invoiceNo;
  late String date;
  late String amount;
  late String companyName;

  OrderPayload.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] ?? "";
    companyId = json['company_id'] ?? "";
    invoiceNo = json['invoice_no'] ?? "";
    date = json['date'] ?? "";
    amount = json['amount'] ?? "";
    companyName = json['company_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['company_id'] = this.companyId;
    data['invoice_no'] = this.invoiceNo;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['company_name'] = this.companyName;
    return data;
  }
}
