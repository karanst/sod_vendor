class ChangePasswordRequest {
  String userId;
  String password;
  String newPassword;
  ChangePasswordRequest(
      {required this.userId,
      required this.password,
      required this.newPassword});

  Map<String, dynamic> tojson() => {
        "user_id": this.userId,
        'password': this.password,
        'npassword': this.newPassword,
        'cpassword': this.newPassword
      };
}
