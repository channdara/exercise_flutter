import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String title;

  const EmptyScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)));
  }
}
