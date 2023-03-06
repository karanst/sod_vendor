class PaymentHistoryRequest {
  String userId;
  PaymentHistoryRequest({
    required this.userId,
  });

  Map<String, dynamic> tojson() => {
        "user_id": this.userId,
      };
}
