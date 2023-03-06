class IamOnlineRequest {
  String userid;
  String status;
  IamOnlineRequest({required this.userid, required this.status});

  Map<String, dynamic> tojson() =>
      {"user_id": this.userid, "status": this.status};
}
