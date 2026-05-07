class RewardIncomeModel {
  final int id;
  final String club;
  final double direct;
  final double totalTeam;
  final String reward;
  final String image;

  RewardIncomeModel({
    required this.id,
    required this.club,
    required this.direct,
    required this.totalTeam,
    required this.reward,
    required this.image,
  });

  factory RewardIncomeModel.fromJson(Map<String, dynamic> json) {
    return RewardIncomeModel(
      id: json['Id'] ?? 0,
      club: json['Club'] ?? '',
      direct: (json['Direct'] ?? 0).toDouble(),
      totalTeam: (json['TotalTeam'] ?? 0).toDouble(),
      reward: json['Reward'] ?? '',
      image: json['Image'] ?? '',
    );
  }
}