import 'package:ezy_pod/src/features/deliveries/domain/models/address_model.dart';
import 'package:ezy_pod/src/features/home/domain/models/deliveries.dart';

abstract class HomeRepository {
  Future<DeliveriesModel> fetchDeliveries();

  Future<List<AddressResult>> fetchAddress();
}
