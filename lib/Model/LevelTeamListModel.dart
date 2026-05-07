class LevelTeamListModel {

  final String userId;
  final String name;
  final String sponsorId;
  final String sponsorName;
  final String date;
  final bool active;
  final int level;

  LevelTeamListModel({
    required this.userId,
    required this.name,
    required this.sponsorId,
    required this.sponsorName,
    required this.date,
    required this.active,
    required this.level,
  });

  factory LevelTeamListModel.fromJson(
      Map<String, dynamic> json) {

    return LevelTeamListModel(

      userId: json['UserId'] ?? '',

      name: json['Name'] ?? '',

      sponsorId: json['SponsorId'] ?? '',

      sponsorName: json['SponsorName'] ?? '',

      date: json['date'] ?? '',

      active: json['Active'] ?? false,

      level: json['Level'] ?? 0,
    );
  }
}