class LevelIncomeModel {
  final int id;
  final String userId;
  final String remarks;
  final double amount;
  final String fromUserId;
  final String incomeType;
  final String date;
  final int level;
  final String status;
  final String paymentDate;

  LevelIncomeModel({
    required this.id,
    required this.userId,
    required this.remarks,
    required this.amount,
    required this.fromUserId,
    required this.incomeType,
    required this.date,
    required this.level,
    required this.status,
    required this.paymentDate,
  });

  factory LevelIncomeModel.fromJson(Map<String, dynamic> json) {
    return LevelIncomeModel(
      id: json['Id'] ?? 0,
      userId: json['UserId'] ?? '',
      remarks: json['Remarks'] ?? '',
      amount: (json['Amount'] ?? 0).toDouble(),
      fromUserId: json['FromUserId'] ?? '',
      incomeType: json['IncomeType'] ?? '',
      date: json['Date'] ?? '',
      level: json['Level'] ?? 0,
      status: json['Status'] ?? '',
      paymentDate: json['PaymentDate'] ?? '',
    );
  }
}