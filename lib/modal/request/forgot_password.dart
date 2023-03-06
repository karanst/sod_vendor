class ForgotPasswordRequest {
  String email;
  ForgotPasswordRequest({
    required this.email,
  });

  Map<String, dynamic> tojson() => {
        "email": this.email,
      };
}
