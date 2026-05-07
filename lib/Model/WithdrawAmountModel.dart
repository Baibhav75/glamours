class WithdrawAmountModel {

  final int id;
  final String userId;
  final String remarks;
  final double amount;
  final String incomeType;
  final String date;
  final String userName;
  final String flag;
  final String status;
  final String? paymentDate;

  WithdrawAmountModel({
    required this.id,
    required this.userId,
    required this.remarks,
    required this.amount,
    required this.incomeType,
    required this.date,
    required this.userName,
    required this.flag,
    required this.status,
    required this.paymentDate,
  });

  factory WithdrawAmountModel.fromJson(
      Map<String, dynamic> json) {

    return WithdrawAmountModel(

      id: json['Id'] ?? 0,

      userId: json['UserId'] ?? '',

      remarks: json['Remarks'] ?? '',

      amount: (json['Amount'] ?? 0).toDouble(),

      incomeType: json['IncomeType'] ?? '',

      date: json['Date'] ?? '',

      userName: json['UserName'] ?? '',

      flag: json['Flag'] ?? '',

      status: json['Status'] ?? '',

      paymentDate: json['PaymentDate'],
    );
  }
}