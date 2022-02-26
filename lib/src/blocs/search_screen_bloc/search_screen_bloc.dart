import 'package:exercise_flutter/src/blocs/search_screen_bloc/search_screen_state.dart';
import 'package:exercise_flutter/src/models/shop.dart';
import 'package:exercise_flutter/src/ui/screens/google_maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenBloc extends Cubit<SearchScreenState> {
  SearchScreenBloc() : super(SearchScreenStateInit());

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isMapIcon = true;
  final List<Widget> stackScreen = [];

  void dispose() {
    controller.dispose();
    focusNode.dispose();
    close();
  }

  void search(String query) {
    emit(SearchScreenStateLoading());
    if (stackScreen.length > 1) {
      isMapIcon = true;
      stackScreen.removeLast();
    }
    Future.delayed(const Duration(seconds: 2), () {
      emit(SearchScreenStateSuccess());
    });
  }

  void switchMapIcon() {
    isMapIcon = !isMapIcon;
    isMapIcon
        ? stackScreen.removeLast()
        : stackScreen.add(GoogleMapsScreen(Shop.tmpShops));
    emit(SearchScreenStateSwitchAppBarIcon());
  }
}
