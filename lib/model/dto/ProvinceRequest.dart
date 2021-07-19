class ProvinceRequest {
  String cutProvince;
  String cutRegion;
  String name;

  ProvinceRequest({
    required this.cutProvince,
    required this.cutRegion,
    required this.name,
  });

  factory ProvinceRequest.fromJson(Map<String, dynamic> json) => ProvinceRequest(
        cutProvince: json['cut_comuna'],
        cutRegion: json['cut_region'],
        name: json['comuna'],
      );
}
