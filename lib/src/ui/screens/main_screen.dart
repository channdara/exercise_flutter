import 'package:exercise_flutter/src/blocs/main_screen_bloc.dart';
import 'package:exercise_flutter/src/models/bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenBloc _bloc = MainScreenBloc();

  @override
  void initState() {
    _bloc.requestLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _bloc.controller,
      navBarStyle: NavBarStyle.style6,
      bottomScreenMargin: 0.0,
      screens: BottomNavigationItem.tmpBottomNavScreen,
      items: BottomNavigationItem.tmpBottomNav
          .map((e) => PersistentBottomNavBarItem(
                icon: Icon(e.icon, size: 22.0),
                title: e.title,
                textStyle: const TextStyle(fontSize: 10.0),
                activeColorPrimary: Colors.red,
              ))
          .toList(),
    );
  }
}
