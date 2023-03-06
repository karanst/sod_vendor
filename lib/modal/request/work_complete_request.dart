class WorkDoneRequest {
  String bookingId;
  String otp;
  String workHours;
  WorkDoneRequest(
      {required this.bookingId, required this.otp, required this.workHours});

  Map<String, dynamic> tojson() => {
        "booking_id": this.bookingId,
        "otp": this.otp,
        "work_hours": this.workHours,
        "status": "work done"
      };
}
