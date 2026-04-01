class ChangePasswordModel {
  final String selfId;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordModel({
    required this.selfId,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "Self_id": selfId,
      "OldPassword": oldPassword,
      "NewPassword": newPassword,
      "ConfirmPassword": confirmPassword,
    };
  }
}