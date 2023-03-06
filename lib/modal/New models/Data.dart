// class Data {
//   Data({
//       required this.id,
//     required this.userId,
//     required this.amount,
//     required this.transactionId,
//     required this.createdAt,
//     required this.updatedAt,});
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     userId = json['user_id'];
//     amount = json['amount'];
//     transactionId = json['transaction_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//   String id;
//   String userId;
//   String amount;
//   String transactionId;
//   String createdAt;
//   String updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['user_id'] = userId;
//     map['amount'] = amount;
//     map['transaction_id'] = transactionId;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     return map;
//   }
//
// }