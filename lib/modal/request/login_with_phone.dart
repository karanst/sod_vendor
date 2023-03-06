class PhoneLoginRequest {
  String number;
  String password;
  String deviceToken;
  PhoneLoginRequest(
      {required this.number,
      required this.deviceToken,
      required this.password});

  Map<String, dynamic> tojson() => {
        "contact": this.number,
        "password": this.password,
        "device_token": this.deviceToken
      };
}
