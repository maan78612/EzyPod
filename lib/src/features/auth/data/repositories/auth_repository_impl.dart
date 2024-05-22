import 'package:ezy_pod/src/core/services/network/api_data_source.dart';
import 'package:ezy_pod/src/features/auth/domain/models/user.dart';
import 'package:ezy_pod/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // final AuthRemoteDataSource _remoteDataSource;
  // final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(// this._remoteDataSource,
      // this._localDataSource,
      );

  @override
  Future<User> login(
      {required String username, required String password}) async {
    try {
      var value = await NetworkApi.instance.get(url: "");
      return User.fromJson(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(User user) async {
    // Implement register logic using _remoteDataSource or _localDataSource
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

// ...
}
