class RegisterModel {
  final bool status;
  final String message;
  final RegisterData data;

  RegisterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'],
      message: json['message'],
      data: RegisterData.fromJson(json['data']),
    );
  }
}

class RegisterData {
  final int id;
  final String fullName;
  final String email;
  final String selfId;
  final String mpin;

  RegisterData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.selfId,
    required this.mpin,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['Id'],
      fullName: json['FullName'],
      email: json['Email'],
      selfId: json['Self_Id'],
      mpin: json['Mpin'],
    );
  }
}