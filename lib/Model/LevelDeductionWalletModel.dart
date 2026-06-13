class LevelDeductionWalletModel {

  final int id;
  final String userId;
  final double amount;
  final String flag;
  final String status;
  final String fromUserId;
  final String remarks;
  final String createDate;
  final int? level;
  final String fromUserName;

  LevelDeductionWalletModel({

    required this.id,
    required this.userId,
    required this.amount,
    required this.flag,
    required this.status,
    required this.fromUserId,
    required this.remarks,
    required this.createDate,
    required this.level,
    required this.fromUserName,
  });

  factory LevelDeductionWalletModel.fromJson(
      Map<String, dynamic> json) {

    return LevelDeductionWalletModel(

      id: json['Id'] ?? 0,

      userId: json['UserId'] ?? '',

      amount:
      (json['Amount'] ?? 0).toDouble(),

      flag: json['Flag'] ?? '',

      status: json['Status'] ?? '',

      fromUserId:
      json['fromUserId'] ?? '',

      remarks:
      json['Remarks'] ?? '',

      createDate:
      json['createDate'] ?? '',

      level: json['level'],

      fromUserName:
      json['FromUserName'] ?? '',
    );
  }
}