class PoolIncomeModel {
  final int id;
  final String userId;
  final String remarks;
  final double amount;
  final String fromUserId;
  final String incomeType;
  final String date;
  final String userName;
  final String flag;
  final String orderId;
  final int level;
  final String status;
  final String paymentDate;

  PoolIncomeModel({
    required this.id,
    required this.userId,
    required this.remarks,
    required this.amount,
    required this.fromUserId,
    required this.incomeType,
    required this.date,
    required this.userName,
    required this.flag,
    required this.orderId,
    required this.level,
    required this.status,
    required this.paymentDate,
  });

  factory PoolIncomeModel.fromJson(Map<String, dynamic> json) {
    return PoolIncomeModel(
      id: json['Id'] ?? 0,
      userId: json['UserId'] ?? '',
      remarks: json['Remarks'] ?? '',
      amount: (json['Amount'] ?? 0).toDouble(),
      fromUserId: json['FromUserId'] ?? '',
      incomeType: json['IncomeType'] ?? '',
      date: json['Date'] ?? '',
      userName: json['UserName'] ?? '',
      flag: json['Flag'] ?? '',
      orderId: json['Orderid'] ?? '',
      level: json['Level'] ?? 0,
      status: json['Status'] ?? '',
      paymentDate: json['PaymentDate'] ?? '',
    );
  }
}