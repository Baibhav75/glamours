class WalletModel {
  final bool status;
  final String message;
  final WalletData? data;

  WalletModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      status: json['status'] ?? json['Status'] ?? false,
      message: json['message'] ?? json['Message'] ?? "",
      data: json['data'] != null ? WalletData.fromJson(json['data']) : (json['Data'] != null ? WalletData.fromJson(json['Data']) : null),
    );
  }
}

class WalletData {
  final double walletBalance;
  final double credit;
  final double debit;
  final List<TransactionModel> transactions;

  WalletData({
    required this.walletBalance,
    required this.credit,
    required this.debit,
    required this.transactions,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      walletBalance: (json['WalletBalance'] ?? json['walletBalance'] ?? 0).toDouble(),
      credit: (json['Credit'] ?? json['credit'] ?? 0).toDouble(),
      debit: (json['Debit'] ?? json['debit'] ?? 0).toDouble(),
      transactions: (json['Transactions'] ?? (json['transactions'] as List?) ?? [])
          .map<TransactionModel>((e) => TransactionModel.fromJson(e))
          .toList(),
    );
  }
}

class TransactionModel {
  final int id;
  final double amount;
  final String flag;
  final String incomeType;
  final String status;
  final String fromUserId;
  final String userId;
  final String date;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.flag,
    required this.incomeType,
    required this.status,
    required this.fromUserId,
    required this.userId,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['Id'] ?? json['id'] ?? 0,
      amount: (json['Amount'] ?? json['amount'] ?? 0).toDouble(),
      flag: json['Flag'] ?? json['flag'] ?? "",
      incomeType: json['IncomeType'] ?? json['incomeType'] ?? "",
      status: json['Status'] ?? json['status'] ?? "",
      fromUserId: json['FromUserId'] ?? json['fromUserId'] ?? "",
      userId: json['UserId'] ?? json['userId'] ?? "",
      date: json['Date'] ?? json['date'] ?? "",
    );
  }
}