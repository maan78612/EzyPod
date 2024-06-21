// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  int count;
  dynamic next;
  dynamic previous;
  List<AddressResult> results;

  AddressModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<AddressResult>.from(json["results"].map((x) => AddressResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class AddressResult {
  int id;
  String address1;
  String address2;
  String street;
  String city;
  String state;
  String postcode;
  DateTime createdAt;
  DateTime updatedAt;

  AddressResult({
    required this.id,
    required this.address1,
    required this.address2,
    required this.street,
    required this.city,
    required this.state,
    required this.postcode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressResult.fromJson(Map<String, dynamic> json) => AddressResult(
        id: json["id"],
        address1: json["address_1"],
        address2: json["address_2"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_1": address1,
        "address_2": address2,
        "street": street,
        "city": city,
        "state": state,
        "postcode": postcode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
