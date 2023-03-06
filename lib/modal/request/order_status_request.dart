class OrderStatusRequest {
  String id;
  String statusType;

  OrderStatusRequest({required this.id, required this.statusType});

  Map<String, dynamic> tojson() => {
        "id": this.id,
        "status": this.statusType,
      };
}
