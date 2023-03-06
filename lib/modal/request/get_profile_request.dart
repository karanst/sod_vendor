class GetProfileRequest {
  String vendorId;
  GetProfileRequest({required this.vendorId});

  Map<String, dynamic> tojson() => {
        "vid": this.vendorId,
      };
}
