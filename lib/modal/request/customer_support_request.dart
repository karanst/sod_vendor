class CustomerSupportRequest {
  String receiverId;
  String description;
  CustomerSupportRequest({required this.receiverId, required this.description});

  Map<String, dynamic> tojson() =>
      {"receiver_id": this.receiverId, "description": this.description};
}
