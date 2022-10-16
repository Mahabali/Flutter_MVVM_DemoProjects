import 'package:flutter/material.dart';
import 'package:flutter_mvvm/viewmodels/user_list_view_model.dart';
import 'package:flutter_mvvm/views/UserListView.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

void _refresh(BuildContext context) {}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => UserListViewModel(), child: UserListView()));
  }
}
