class SpecilizationListRequest {
  String serviceId;
  final String id;
  String categoryName;
  String icon;
  String images;
  String type;

  SpecilizationListRequest( this.id, this.type, this.images, this.icon, this.categoryName, {required this.serviceId});

  Map<String, dynamic> tojson() => {
        "cat_id": this.serviceId,
      };
}
