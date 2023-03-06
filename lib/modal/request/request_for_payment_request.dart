class RequestForPaymentRequest {
  String userId;
  String amount;
  RequestForPaymentRequest({required this.userId, required this.amount});

  Map<String, dynamic> tojson() =>
      {"user_id": this.userId, "amount": this.amount};
}
