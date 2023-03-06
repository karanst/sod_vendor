class EmailLoginRequest {
  String email;
  String password;
  String deviceToken;
  EmailLoginRequest(
      {required this.email, required this.password, required this.deviceToken});

  Map<String, dynamic> tojson() => {
        "email": this.email,
        "password": this.password,
        'device_token': this.deviceToken
      };
}
