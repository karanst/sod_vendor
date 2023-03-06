class GetNewOrderRequest {
  String userId;
  GetNewOrderRequest({required this.userId});

  Map<String, dynamic> tojson() => {
        "user_id": this.userId,
      };
}
