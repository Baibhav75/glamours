class ReferralLinkModel {

  final String referralLink;

  ReferralLinkModel({
    required this.referralLink,
  });

  factory ReferralLinkModel.fromJson(
      Map<String, dynamic> json) {

    return ReferralLinkModel(
      referralLink:
      json['referralLink'] ?? '',
    );
  }
}