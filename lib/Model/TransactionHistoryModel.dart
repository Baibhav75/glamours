class TransactionHistoryModel {

  final int srNo;
  final String dateTime;
  final String customerId;
  final String customerName;
  final String customerMobile;
  final String remarks;
  final String flag;
  final String pointEarned;

  TransactionHistoryModel({

    required this.srNo,
    required this.dateTime,
    required this.customerId,
    required this.customerName,
    required this.customerMobile,
    required this.remarks,
    required this.flag,
    required this.pointEarned,
  });

  factory TransactionHistoryModel.fromJson(
      Map<String, dynamic> json) {

    return TransactionHistoryModel(

      srNo: json['SrNo'] ?? 0,

      dateTime: json['DateTime'] ?? '',

      customerId: json['CustomerId'] ?? '',

      customerName: json['CustomerName'] ?? '',

      customerMobile:
      json['CustomerMobile'] ?? '',

      remarks: json['Remarks'] ?? '',

      flag: json['Flag'] ?? '',

      pointEarned:
      json['PointEarned'] ?? '',
    );
  }
}