class SignInModel {
  final bool status;
  final String message;
  final UserData? data;

  SignInModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final int id;
  final String selfId;
  final String fullName;
  final String mobile;
  final String email;
  final String joiningDate;
  final String? sponsorId;

  UserData({
    required this.id,
    required this.selfId,
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.joiningDate,
    this.sponsorId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['Id'] ?? 0,
      selfId: json['Self_Id'] ?? '',
      fullName: json['FullName'] ?? '',
      mobile: json['Mobile'] ?? '',
      email: json['Email'] ?? '',
      joiningDate: json['JoiningDate'] ?? '',
      sponsorId: json['SponserId'],
    );
  }
}