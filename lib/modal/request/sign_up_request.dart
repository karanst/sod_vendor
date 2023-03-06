class SignUpRequest {
  String name;
  String email;
  String mobile;
  String aadharNo;
  String password;
  String address;
  String latitude;
  String longitude;
  String deviceToken;
  String role ;
  String categoryId ;
  SignUpRequest(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.password,
      required this.aadharNo,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.deviceToken ,
      required this.role ,
        required this.categoryId ,
      });

  Map<String, dynamic> tojson() => {
        "uname": this.name,
        "email": this.email,
        "mobile": this.mobile,
        "password": this.password,
        "adhar_no": this.aadharNo,
        "address": this.address,
        "lang": this.longitude,
        "lat": this.latitude,
        'device_token': this.deviceToken ,
    'role' : this.role ,
    'category_id' : this.categoryId
      };
}
