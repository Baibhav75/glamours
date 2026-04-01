class ProfileModel {
  final bool status;
  final String message;
  final ProfileData? data;

  ProfileModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // 1. Robust status check (status, Status, success, Success)
    bool status = false;
    if (json.containsKey('status')) status = json['status'] == true || json['status'] == 1 || json['status'] == "true";
    else if (json.containsKey('Status')) status = json['Status'] == true || json['Status'] == 1 || json['Status'] == "true";
    else if (json.containsKey('success')) status = json['success'] == true;

    // 2. Look for data in common keys (data, Data, Result, Table, result, profile)
    var dataJson = json['data'] ?? json['Data'] ?? json['Result'] ?? json['Table'] ?? json['result'] ?? json['profile'];
    
    // 3. If data is still null, maybe the data is at the root level?
    // Check if common profile fields are present at the root
    if (dataJson == null && (json.containsKey('Self_Id') || json.containsKey('FullName') || json.containsKey('Email'))) {
      dataJson = json;
    }

    ProfileData? parsedData;
    if (dataJson != null) {
      if (dataJson is List && dataJson.isNotEmpty) {
        parsedData = ProfileData.fromJson(dataJson[0]);
      } else if (dataJson is Map<String, dynamic>) {
        parsedData = ProfileData.fromJson(dataJson);
      }
    }

    return ProfileModel(
      status: status,
      message: (json['message'] ?? json['Message'] ?? json['msg'] ?? '').toString(),
      data: parsedData,
    );
  }
}

class ProfileData {
  final dynamic id;
  final String? sponsorId;
  final String? sponsorName;
  final String selfId;
  final String fullName;
  final String mobile;
  final String email;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? joiningDate;
  final String? profilePic;
  final String? gender;
  final String? dob;
  final String? userType;

  ProfileData({
    required this.id,
    this.sponsorId,
    this.sponsorName,
    required this.selfId,
    required this.fullName,
    required this.mobile,
    required this.email,
    this.address,
    this.city,
    this.state,
    this.country,
    this.joiningDate,
    this.profilePic,
    this.gender,
    this.dob,
    this.userType,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['Id'] ?? json['id'],
      sponsorId: json['SponserId']?.toString() ?? json['SponsorId']?.toString() ?? json['sponser_id']?.toString(),
      sponsorName: json['SponserName']?.toString() ?? json['SponsorName']?.toString() ?? json['sponser_name']?.toString(),
      selfId: json['Self_Id']?.toString() ?? json['self_id']?.toString() ?? '',
      fullName: json['FullName']?.toString() ?? json['full_name']?.toString() ?? json['name']?.toString() ?? '',
      mobile: json['Mobile']?.toString() ?? json['mobile']?.toString() ?? '',
      email: json['Email']?.toString() ?? json['email']?.toString() ?? '',
      address: json['Address']?.toString() ?? json['address']?.toString(),
      city: json['City']?.toString() ?? json['city']?.toString(),
      state: json['State']?.toString() ?? json['state']?.toString(),
      country: json['Country']?.toString() ?? json['country']?.toString(),
      joiningDate: json['JoiningDate']?.toString() ?? json['joining_date']?.toString(),
      profilePic: json['ProfilePic']?.toString() ?? json['profile_pic']?.toString(),
      gender: json['Gender']?.toString() ?? json['gender']?.toString(),
      dob: json['DOB']?.toString() ?? json['dob']?.toString(),
      userType: json['UserType']?.toString() ?? json['user_type']?.toString(),
    );
  }
}