import 'package:ezy_pod/src/features/auth/domain/models/user.dart';

abstract class DeliveryRepository {
  Future<User> fetchDeliveries();
}
