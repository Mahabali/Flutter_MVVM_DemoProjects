import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/repository/ApiProvider/api_response.dart';

import '../models/user.dart';
import '../repository/UserApiServices.dart';
import '../repository/repository_provider.dart';

class UserListViewModel extends ChangeNotifier {
  late List<User> userList = List.empty();
  late bool isLoading = false;
  late String errorMessage = "";

  UserListViewModel() {
    loadUserList();
  }

  void loadUserList() async {
    updateLoadingState(true);
    UserApiResponse userListResponse =
        await RepositoryProvider.instance.getUserApiProvider();
    Future.delayed(const Duration(seconds: 3),(){
    if (userListResponse.isSuccess) {
      if (userListResponse.isSuccess) {
        updateUserList(userListResponse.userList!);
      } else {
        updateErrorMessage(userListResponse.errorMessage!);
      }
    } else {
      updateErrorMessage(userListResponse.errorMessage!);
    }
    updateLoadingState(false);
    });
  }

  void updateUserList(List<User> list) {
    userList = list;
    errorMessage = "";
    updateLoadingState(false);
  }

  void updateErrorMessage(String error) {
    userList = List.empty();
    errorMessage = error;
    updateLoadingState(false);
  }

  void updateLoadingState(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}
