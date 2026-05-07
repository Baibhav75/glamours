class UpdateProfileRequest {
  final String selfId;
  final String fullName;
  final String mobile;
  final String email;
  final String address;
  final String city;
  final String state;
  final String country;
  final String gender;

  UpdateProfileRequest({
    required this.selfId,
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      "Self_Id": selfId,
      "FullName": fullName,
      "Mobile": mobile,
      "Email": email,
      "Address": address,
      "City": city,
      "State": state,
      "Country": country,
      "Gender": gender,
    };
  }
}