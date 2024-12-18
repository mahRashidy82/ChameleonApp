class ChangePassword {
  ChangePassword({
    this.data,
    this.status,
    this.message,
    this.endUserMessage,
    this.isSuccess,
    this.token,
  });

  ChangePassword.fromJson(dynamic json) {
    data = json['data'];
    status = json['status'];
    message = json['message'];
    endUserMessage = json['endUserMessage'];
    isSuccess = json['isSuccess'];
    token = json['token'];
  }

  dynamic data;
  int? status;
  String? message;
  String? endUserMessage;
  bool? isSuccess;
  dynamic token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['status'] = status;
    map['message'] = message;
    map['endUserMessage'] = endUserMessage;
    map['isSuccess'] = isSuccess;
    map['token'] = token;
    return map;
  }
}
