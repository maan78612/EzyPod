class Deliveries {
  int? id;

  DateTime? createdAt;

  Deliveries({this.id, this.createdAt});

  Deliveries.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['created_at'] = createdAt;
    return data;
  }
}
