import 'dart:io';

import 'package:exercise_flutter/src/blocs/search_screen_bloc/search_screen_bloc.dart';
import 'package:exercise_flutter/src/blocs/search_screen_bloc/search_screen_state.dart';
import 'package:exercise_flutter/src/models/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchScreenBloc _bloc = SearchScreenBloc();

  @override
  void initState() {
    _bloc.stackScreen.add(_buildBody());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          return Stack(children: _bloc.stackScreen);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: CupertinoTextField(
        controller: _bloc.controller,
        focusNode: _bloc.focusNode,
        padding: const EdgeInsets.all(8.0),
        autofocus: true,
        placeholder: 'Search',
        textInputAction: TextInputAction.search,
        prefix: const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Icon(
            Icons.search,
            color: Colors.red,
            size: 22.0,
          ),
        ),
        onSubmitted: (text) {
          _bloc.search(text);
        },
      ),
      actions: [
        IconButton(
          icon: _buildMapIconButton(),
          onPressed: () {
            _bloc.focusNode.unfocus();
            _bloc.switchMapIcon();
          },
        ),
      ],
    );
  }

  Widget _buildMapIconButton() {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        if (state is SearchScreenStateSwitchAppBarIcon) {
          return _bloc.isMapIcon
              ? const Icon(Icons.public)
              : const Icon(Icons.list);
        }
        return const Icon(Icons.public);
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _bloc,
      buildWhen: (p, c) => c is! SearchScreenStateSwitchAppBarIcon,
      builder: (context, state) {
        if (state is SearchScreenStateLoading) {
          return _buildLoading();
        }
        if (state is SearchScreenStateSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey.shade800,
                padding: const EdgeInsets.only(
                  left: 6.0,
                  top: 6.0,
                  bottom: 6.0,
                ),
                child: Row(
                  children: [
                    _buildFilterItem('Filter', icon: Icons.filter_list),
                    _buildFilterItem('Ranking'),
                    _buildFilterItem('View'),
                    _buildFilterItem('Price'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _text('${Shop.tmpShops.length} restaurants found'),
              ),
              _buildShopListView(),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Platform.isAndroid
          ? const CircularProgressIndicator()
          : const CupertinoActivityIndicator(),
    );
  }

  Widget _buildFilterItem(String content, {IconData? icon}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        height: 24.0,
        margin: const EdgeInsets.only(right: 6.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: icon == null
            ? _text(content, size: 10.0, color: Colors.white)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 16.0),
                  const SizedBox(width: 4.0),
                  _text(content, size: 10.0, color: Colors.white)
                ],
              ),
      ),
    );
  }

  Widget _buildShopListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: Shop.tmpShops.length,
        itemBuilder: (context, index) {
          final item = Shop.tmpShops.elementAt(index);
          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.0, color: Colors.grey),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shopImage(item.image),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shopName(item.shopName, item.distance),
                      const SizedBox(height: 6.0),
                      _ratingAndView(item.rating, item.view),
                      const SizedBox(height: 2.0),
                      _text(item.getRatingAndReview, color: Colors.grey),
                      const SizedBox(height: 2.0),
                      _shopTypeAndStatus(
                        item.getShopType,
                        item.location,
                        item.shopStatus,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _shopImage(String image) {
    return Card(
      margin: const EdgeInsets.only(),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Image.asset(image, height: 70.0, width: 90.0, fit: BoxFit.cover),
    );
  }

  Widget _shopName(String name, double distance) {
    return Row(
      children: [
        Expanded(child: Text(name)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700, width: 0.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: _text('$distance km', size: 10.0),
        ),
      ],
    );
  }

  Widget _ratingAndView(double rating, int view) {
    return Row(
      children: [
        Wrap(
          children: List.generate(
            5,
            (index) => _icon(Icons.star, color: Colors.grey.shade400),
          ),
        ),
        _text('  $rating   |   '),
        _icon(Icons.remove_red_eye),
        _text(' $view Views'),
      ],
    );
  }

  Widget _shopTypeAndStatus(String type, String location, String status) {
    return Row(
      children: [
        _icon(Icons.restaurant),
        _text('  $type   |   '),
        _icon(Icons.location_on),
        _text(' $location'),
        Expanded(
          child: _text(status, color: Colors.green, align: TextAlign.end),
        ),
      ],
    );
  }

  Widget _icon(IconData icon, {double size = 14.0, Color? color}) {
    return Icon(icon, size: size, color: color ?? Colors.grey.shade700);
  }

  Widget _text(
    String text, {
    double size = 12.0,
    Color? color,
    TextAlign? align,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        color: color ?? Colors.grey.shade700,
      ),
    );
  }
}
