
import 'package:get/get.dart';

import '../models/user.dart';
import '../repository/UserApiServices.dart';
import '../repository/repository_provider.dart';

class UserListViewModel extends GetxController {
  var userList = <User>[].obs;
  var isLoading = false.obs;
  late String errorMessage = "";

  UserListViewModel() {
    loadUserList();
  }
  void loadUserList() async {
    updateLoadingState(true);
    UserApiResponse userListResponse =
        await RepositoryProvider.instance.getUserApiProvider();
    Future.delayed(const Duration(seconds: 3), () {
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
    userList.value = list;
    errorMessage = "";
    updateLoadingState(false);
  }

  void updateErrorMessage(String error) {
    userList.value = List.empty();
    errorMessage = error;
    updateLoadingState(false);
  }

  void updateLoadingState(bool loading) {
    isLoading.value = loading;
    update();
  }
}
