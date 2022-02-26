import 'package:exercise_flutter/src/ui/screens/empty_screen.dart';
import 'package:exercise_flutter/src/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationItem {
  final IconData icon;
  final String title;

  BottomNavigationItem(this.icon, this.title);

  static final List<BottomNavigationItem> tmpBottomNav = [
    BottomNavigationItem(Icons.home, 'Home'),
    BottomNavigationItem(Icons.discount, 'Coupon'),
    BottomNavigationItem(Icons.favorite, 'Favorite'),
    BottomNavigationItem(Icons.person, 'Me')
  ];

  static const List<Widget> tmpBottomNavScreen = [
    HomeScreen(),
    EmptyScreen('Coupon'),
    EmptyScreen('Favorite'),
    EmptyScreen('Me'),
  ];
}
