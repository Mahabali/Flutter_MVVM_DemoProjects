import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_mvvm/constatnts/constants.dart';
import 'package:flutter_mvvm/models/User.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_mvvm/repository/ApiProvider/api_response.dart';


class NetworkApiServices {
  late Dio dioInstance;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool isConnectedToInternet = false;
  NetworkApiServices() {
    dioInstance = getDio();
    observeConnectivity();
  }
  Dio getDio() {
    var options = BaseOptions(
      baseUrl: Constants.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);
    return dio;
  }

  void observeConnectivity() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        isConnectedToInternet = true;
      } else {
        isConnectedToInternet = false;
      }
    });
  }

  ApiResponse parseResponse(Response<dynamic> response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      var responseData = response.data;
      var status = ApiStatus.SUCCESS;
      var apiResponse = ApiResponse(responseData, status, null);
      return apiResponse;
    } else {
      var status = ApiStatus.ERROR;
      var apiResponse = ApiResponse(null, status, response.statusMessage);
      return apiResponse;
    }
  }
}
