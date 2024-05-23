enum DeliveryStatus {
  pendingDeliveries(1, 'Pending Deliveries'),
  deliveredToday(2, 'Delivered Today'),
  undeliveredToday(3, 'Undelivered Today');

  final int value;
  final String name;

  const DeliveryStatus(this.value, this.name);

  static DeliveryStatus? fromValue(int? value) {
    return values.firstWhere((element) => element.value == value);
  }
}