class AutoPoolMemberModel {

  final int level;

  final List<PoolUser> users;

  AutoPoolMemberModel({

    required this.level,
    required this.users,
  });

  factory AutoPoolMemberModel.fromJson(
      Map<String, dynamic> json) {

    return AutoPoolMemberModel(

      level: json['Level'] ?? 0,

      users: (json['Users'] as List<dynamic>?)

          ?.map((e) => PoolUser.fromJson(e))

          .toList() ?? [],
    );
  }
}

class PoolUser {

  final String selfId;
  final String fullName;
  final String sponsorId;
  final String sponsorName;
  final String joiningDate;
  final bool isActive;
  final String poolName;

  PoolUser({

    required this.selfId,
    required this.fullName,
    required this.sponsorId,
    required this.sponsorName,
    required this.joiningDate,
    required this.isActive,
    required this.poolName,
  });

  factory PoolUser.fromJson(
      Map<String, dynamic> json) {

    return PoolUser(

      selfId: json['Self_Id'] ?? '',

      fullName: json['FullName'] ?? '',

      sponsorId: json['SponserId'] ?? '',

      sponsorName: json['SponserName'] ?? '',

      joiningDate:
      json['pool2Date'] ??
          json['JoiningDate'] ??
          '',

      isActive:
      json['IsActive'] ?? false,

      poolName:
      json['pool2'] ??
          "Public Pool",
    );
  }
}