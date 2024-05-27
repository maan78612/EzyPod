class Notifications {
  int? id;

  DateTime? createdAt;

  Notifications({this.id, this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['created_at'] = createdAt;
    return data;
  }
}
