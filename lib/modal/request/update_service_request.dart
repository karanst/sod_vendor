class UpdateServiceRequest {
  String userid;
  String serviceType;
  String specilization;
  String time;
  UpdateServiceRequest(
      {required this.userid,
      required this.serviceType,
      required this.specilization,
      required this.time});

  Map<String, dynamic> tojson() => {
        "user_id": this.userid,
        "service_type": this.serviceType,
        "specilization": this.specilization,
        "time": this.time,
      };
}
