import 'package:responsive_admin_dashboard/services/network/api_client/model/common_response.dart';

class PaymentResponse extends CommonResponse {
  late List<PaymentPayload> payload;

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      payload = <PaymentPayload>[];
      json['payload'].forEach((v) {
        payload.add(new PaymentPayload.fromJson(v));
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

class PaymentPayload {
  late String paymentId;
  late String companyId;
  late String type;
  late String date;
  late String amount;
  late String companyName;

  PaymentPayload.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'] ?? "";
    companyId = json['company_id'] ?? "";
    type = json['type'] ?? "";
    date = json['date'] ?? "";
    amount = json['amount'] ?? "";
    companyName = json['company_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.paymentId;
    data['company_id'] = this.companyId;
    data['type'] = this.type;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['company_name'] = this.companyName;
    return data;
  }
}
