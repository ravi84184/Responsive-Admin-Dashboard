/// common Api response class
class CommonResponse {
  late Error error;
}

class Error {
  late String message;
  late int code;

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message']??"";
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}
