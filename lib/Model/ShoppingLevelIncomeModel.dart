class ShoppingLevelIncomeModel {

  final int id;
  final String userId;
  final double amount;
  final String incomeType;
  final String status;
  final String flag;
  final String date;
  final String fromUserId;
  final String remarks;
  final String fromUserName;

  ShoppingLevelIncomeModel({

    required this.id,
    required this.userId,
    required this.amount,
    required this.incomeType,
    required this.status,
    required this.flag,
    required this.date,
    required this.fromUserId,
    required this.remarks,
    required this.fromUserName,
  });

  factory ShoppingLevelIncomeModel.fromJson(
      Map<String, dynamic> json) {

    return ShoppingLevelIncomeModel(

      id: json['Id'] ?? 0,

      userId: json['UserId'] ?? '',

      amount:
      (json['Amount'] ?? 0).toDouble(),

      incomeType:
      json['IncomeType'] ?? '',

      status:
      json['Status'] ?? '',

      flag:
      json['Flag'] ?? '',

      date:
      json['Date'] ?? '',

      fromUserId:
      json['FromUserId'] ?? '',

      remarks:
      json['Remarks'] ?? '',

      fromUserName:
      json['FromUserName'] ?? '',
    );
  }
}