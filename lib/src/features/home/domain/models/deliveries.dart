import 'dart:convert';

import 'package:ezy_pod/src/core/enums/delivery_status.dart';

DeliveriesModel deliveriesModelFromJson(String str) =>
    DeliveriesModel.fromJson(json.decode(str));

String deliveriesModelToJson(DeliveriesModel data) =>
    json.encode(data.toJson());

class DeliveriesModel {
  int count;
  dynamic next;
  dynamic previous;
  List<DeliveriesResult> results;

  DeliveriesModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory DeliveriesModel.fromJson(Map<String, dynamic> json) =>
      DeliveriesModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<DeliveriesResult>.from(
            json["results"].map((x) => DeliveriesResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class DeliveriesResult {
  int id;
  DeliveryStatus status;
  DateTime scheduledDate;
  DateTime deliveredDate;
  String notes;
  bool neighbourCheck;
  dynamic signImg;
  String receiverName;
  String undeliveredReason;
  dynamic fileField;
  DateTime createdAt;
  DateTime updatedAt;
  int orderNumber;
  int customerId;
  int driverId;
  int addressId;

  DeliveriesResult({
    required this.id,
    required this.status,
    required this.scheduledDate,
    required this.deliveredDate,
    required this.notes,
    required this.neighbourCheck,
    required this.signImg,
    required this.receiverName,
    required this.undeliveredReason,
    required this.fileField,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.customerId,
    required this.driverId,
    required this.addressId,
  });

  factory DeliveriesResult.fromJson(Map<String, dynamic> json) => DeliveriesResult(
        id: json["id"],
        status: _statusFromString(json["status"]),
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        deliveredDate: DateTime.parse(json["delivered_date"]),
        notes: json["notes"],
        neighbourCheck: json["neighbour_check"],
        signImg: json["sign_img"],
        receiverName: json["receiver_name"],
        undeliveredReason: json["undelivered_reason"],
        fileField: json["file_field"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderNumber: json["order_number"],
        customerId: json["customer_id"],
        driverId: json["driver_id"],
        addressId: json["address_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
    "status": _statusToString(status),
        "scheduled_date": scheduledDate.toIso8601String(),
        "delivered_date": deliveredDate.toIso8601String(),
        "notes": notes,
        "neighbour_check": neighbourCheck,
        "sign_img": signImg,
        "receiver_name": receiverName,
        "undelivered_reason": undeliveredReason,
        "file_field": fileField,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_number": orderNumber,
        "customer_id": customerId,
        "driver_id": driverId,
        "address_id": addressId,
      };

  static DeliveryStatus _statusFromString(String status) {
    switch (status) {
      case "pending":
        return DeliveryStatus.pending;
      case "undelivered":
        return DeliveryStatus.undelivered;
      case "delivered":
        return DeliveryStatus.delivered;
      default:
        throw Exception("Unknown status: $status");
    }
  }

  static String _statusToString(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.pending:
        return "pending";
      case DeliveryStatus.undelivered:
        return "undelivered";
      case DeliveryStatus.delivered:
        return "delivered";
    }
  }
}
