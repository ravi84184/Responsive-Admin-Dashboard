import 'common_response.dart';

/// general response class for API call
class GeneralResponse extends CommonResponse {
  GeneralResponse.fromJson(Map<String, dynamic> json) {
    this.error = Error.fromJson(json['error']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error.toJson();
    return data;
  }
}
