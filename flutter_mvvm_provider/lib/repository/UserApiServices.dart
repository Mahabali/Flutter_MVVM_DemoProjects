import 'package:dio/dio.dart';
import 'package:flutter_mvvm/constatnts/constants.dart';
import 'package:flutter_mvvm/models/user.dart';
import 'package:flutter_mvvm/repository/ApiProvider/network_api_services.dart';

class UserApiResponse {
  List<User>? userList;
  String? errorMessage;
  bool isSuccess = false;
  UserApiResponse(this.userList, this.errorMessage, this.isSuccess);
}

class UserApiServices {
  Future<UserApiResponse> getUserDataList(
      NetworkApiServices apiServices) async {
    Dio dioInstance = apiServices.dioInstance;
    try {
      var response = await dioInstance.request(Constants.USER_URL,
          options: Options(method: 'GET'));
      var apiResponse = apiServices.parseResponse(response);
      if (apiResponse.isSuccess()) {
        var userList =
        (apiResponse.data as List).map((x) => User.fromJson(x)).toList();
        return UserApiResponse(userList, null, true);
      } else {
        return UserApiResponse(null, apiResponse.errorMessage, false);
      }
    }
    catch(error){
      var errorObject = error as DioError;
      return UserApiResponse(null, errorObject.message, false);
    }
  }
}
