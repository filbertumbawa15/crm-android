import 'dart:convert';

class CustomersResponseModel {
  String? name;
  String? address;
  String? region;
  String? phone;
  String? province;

  CustomersResponseModel({
    this.name,
    this.address,
    this.region,
    this.phone,
    this.province,
  });

  List<CustomersResponseModel> listCustomers = [];

  CustomersResponseModel.fromListJson(json) {
    for (int i = 0; i < json.length; i++) {
      CustomersResponseModel order = CustomersResponseModel.fromJson(json[i]);
      listCustomers.add(order);
    }
  }

  factory CustomersResponseModel.fromRawJson(String str) =>
      CustomersResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomersResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomersResponseModel(
        name: json["name"],
        address: json["address"],
        region: json["region"],
        phone: json["phone"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "region": region,
        "phone": phone,
        "province": province,
      };
}
