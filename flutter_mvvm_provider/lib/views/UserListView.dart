
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/repository/UserApiServices.dart';
import 'package:flutter_mvvm/viewmodels/user_list_view_model.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserListView extends StatelessWidget {
  ListView buildListView(List<User> userList) {
    var listView = ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {
          var user = userList[index];
          return SizedBox(
            height: 50,
            child: Center(child: Text('${user.name}')),
          );
        });
    return listView;
  }

  @override
  Widget build(BuildContext context) {
    UserListViewModel viewModel = context.watch<UserListViewModel>();

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.errorMessage.isNotEmpty) {
      return Center(child: Text(viewModel.errorMessage!));
    } else {
      return buildListView(viewModel.userList);
    }
  }
}

