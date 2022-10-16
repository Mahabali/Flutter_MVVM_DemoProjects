import 'package:flutter_mvvm/repository/ApiProvider/network_api_services.dart';
import 'package:flutter_mvvm/repository/UserApiServices.dart';

class RepositoryProvider {
  static final RepositoryProvider instance = RepositoryProvider._internal();
  late NetworkApiServices _networkApiServices;
  RepositoryProvider._internal() {
    _networkApiServices = NetworkApiServices();
  }

  Future<UserApiResponse> getUserApiProvider() {
    final userApiServices = UserApiServices();
    return userApiServices.getUserDataList(_networkApiServices);
  }
}

// NetworkApiServices networkApiServices = NetworkApiServices();
// final userApiProvider = FutureProvider<UserApiResponse>((ref) async {
//   final userApiServices = UserApiServices();
//   return userApiServices.getUserDataList(networkApiServices);
// });
