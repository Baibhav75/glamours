class WelcomeLetterModel {

  final int id;
  final String? sponsorId;
  final String sponsorName;
  final String selfId;
  final String fullName;
  final String mobile;
  final String email;
  final String address;
  final String joiningDate;
  final String city;
  final String state;
  final String country;
  final String profilePic;
  final String gender;
  final String? dob;

  WelcomeLetterModel({

    required this.id,
    required this.sponsorId,
    required this.sponsorName,
    required this.selfId,
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.joiningDate,
    required this.city,
    required this.state,
    required this.country,
    required this.profilePic,
    required this.gender,
    required this.dob,
  });

  factory WelcomeLetterModel.fromJson(
      Map<String, dynamic> json) {

    return WelcomeLetterModel(

      id: json['Id'] ?? 0,

      sponsorId: json['SponserId'],

      sponsorName: json['SponserName'] ?? '',

      selfId: json['Self_Id'] ?? '',

      fullName: json['FullName'] ?? '',

      mobile: json['Mobile'] ?? '',

      email: json['Email'] ?? '',

      address: json['Address'] ?? '',

      joiningDate: json['JoiningDate'] ?? '',

      city: json['City'] ?? '',

      state: json['State'] ?? '',

      country: json['Country'] ?? '',

      profilePic: json['ProfilePic'] ?? '',

      gender: json['Gender'] ?? '',

      dob: json['DOB'],
    );
  }
}