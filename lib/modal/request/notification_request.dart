class NotificationRequest {
  String userid;

  NotificationRequest({required this.userid});

  Map<String, dynamic> tojson() => {
        "user_id": this.userid,
      };
}
