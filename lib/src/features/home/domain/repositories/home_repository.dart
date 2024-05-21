import 'package:ezy_pod/src/features/auth/domain/models/user.dart';

abstract class HomeRepository {
  Future<User> fetchDeliveries();
}
