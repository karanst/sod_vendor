class ServiceProfileRequest {
  String userId;
  ServiceProfileRequest({required this.userId});

  Map<String, dynamic> tojson() => {
        "user_id": this.userId,
      };
}
