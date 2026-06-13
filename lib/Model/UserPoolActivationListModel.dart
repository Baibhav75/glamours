class UserPoolActivationListModel {

  final int srNo;
  final int id;
  final String userId;
  final double amount;
  final String status;
  final String paymentType;
  final String poolName;
  final String remark;
  final String createDate;
  final String? uploadScreenshot;

  UserPoolActivationListModel({

    required this.srNo,
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.paymentType,
    required this.poolName,
    required this.remark,
    required this.createDate,
    required this.uploadScreenshot,
  });

  factory UserPoolActivationListModel.fromJson(
      Map<String, dynamic> json) {

    return UserPoolActivationListModel(

      srNo: json['SrNo'] ?? 0,

      id: json['Id'] ?? 0,

      userId: json['UserId'] ?? '',

      amount:
      (json['Amount'] ?? 0).toDouble(),

      status:
      json['Status'] ?? '',

      paymentType:
      json['PaymentType'] ?? '',

      poolName:
      json['PoolName'] ?? '',

      remark:
      json['Remark'] ?? '',

      createDate:
      json['CreateDate'] ?? '',

      uploadScreenshot:
      json['UploadScreenshot'],
    );
  }
}