import 'package:responsive_admin_dashboard/services/network/api_client/model/common_response.dart';

class CompanyResponse extends CommonResponse {
  late List<CompanyPayload> payload;

  CompanyResponse.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      payload = <CompanyPayload>[];
      json['payload'].forEach((v) {
        payload.add(new CompanyPayload.fromJson(v));
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

class CompanyPayload {
  late int id;
  late String companyName;
  late String companyAddress;
  late String companyEmail;
  late String companyMobile;
  late String ownerName;
  late String ownerEmail;
  late String ownerMobile;
  late String paymentCycle;
  late String gstNo;

  CompanyPayload.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['company_id']);
    companyName = json['company_name'] ?? "";
    companyAddress = json['company_address'] ?? "";
    companyEmail = json['company_email'] ?? "";
    companyMobile = json['company_mobile'] ?? "";
    ownerName = json['owner_name'] ?? "";
    ownerEmail = json['owner_email'] ?? "";
    ownerMobile = json['owner_mobile'] ?? "";
    paymentCycle = json['payment_cycle'] ?? "";
    gstNo = json['gst_no'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['company_email'] = this.companyEmail;
    data['company_mobile'] = this.companyMobile;
    data['owner_name'] = this.ownerName;
    data['owner_email'] = this.ownerEmail;
    data['owner_mobile'] = this.ownerMobile;
    data['payment_cycle'] = this.paymentCycle;
    data['gst_no'] = this.gstNo;
    return data;
  }
}
