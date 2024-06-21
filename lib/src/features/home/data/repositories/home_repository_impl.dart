import 'package:ezy_pod/src/core/constants/api_urls.dart';
import 'package:ezy_pod/src/core/services/network/api_data_source.dart';
import 'package:ezy_pod/src/features/deliveries/domain/models/address_model.dart';
import 'package:ezy_pod/src/features/home/domain/models/deliveries.dart';
import 'package:ezy_pod/src/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<DeliveriesModel> fetchDeliveries() async {
    try {
      var value = await NetworkApi.instance.get(url: ApiUrls.getDeliveries);
      return DeliveriesModel.fromJson(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AddressResult>> fetchAddress() async {
    try {
      var value = await NetworkApi.instance.get(url: ApiUrls.getAddresses);

      final addressModel = AddressModel.fromJson(value);
      return addressModel.results;
    } catch (e) {
      rethrow;
    }
  }
}
