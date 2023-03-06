class AcceptRejectRequest {
  String statusType;
  String bookingId;
  String reason;
  AcceptRejectRequest({required this.statusType, required this.bookingId, required this.reason});

  Map<String, dynamic> tojson() =>
      {"status": this.statusType, "id": this.bookingId, "reason": this.reason};
}
