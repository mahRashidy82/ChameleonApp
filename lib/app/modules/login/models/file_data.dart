class MyFileData {
  String? companyCode;
  String? userName;
  String? password;
  String? pinCode;

  MyFileData({this.companyCode, this.userName, this.password, this.pinCode});

  Map<String, dynamic> toJson() {
    return {
      'partnerCode': companyCode,
      'userName': userName,
      'password': password,
      'pinCode': pinCode,
    };
  }

  factory MyFileData.fromJson(Map<String, dynamic> json) {
    return MyFileData(
      companyCode: json['partnerCode'],
      userName: json['userName'],
      password: json['password'],
      pinCode: json['pinCode'],
    );
  }
}


class TypeOfOperation {
  bool? horizontal;

  bool? vertical;

  TypeOfOperation({this.horizontal, this.vertical});

  Map<String, dynamic> toJson() {
    return {
      'horizontal': horizontal,
      'vertical': vertical
    };
  }

  factory TypeOfOperation.fromJson(Map<String, dynamic> json) {
    return TypeOfOperation(
      horizontal: json['horizontal'],
      vertical: json['vertical'],
    );
  }
}
