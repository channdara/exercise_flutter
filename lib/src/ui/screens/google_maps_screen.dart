import 'package:carousel_slider/carousel_slider.dart';
import 'package:exercise_flutter/src/blocs/google_maps_screen_bloc.dart';
import 'package:exercise_flutter/src/constants/asset_constant.dart';
import 'package:exercise_flutter/src/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  final List<Shop> shops;

  const GoogleMapsScreen(this.shops, {Key? key}) : super(key: key);

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final GoogleMapsScreenBloc _bloc = GoogleMapsScreenBloc();

  @override
  void initState() {
    _bloc.initMarkers(widget.shops);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _bloc.initCamPosition(
            widget.shops.first.latLng,
          ),
          markers: _bloc.markers,
          onMapCreated: (controller) {
            _bloc.completer.complete(controller);
          },
        ),
        _buildSlider(),
      ],
    );
  }

  Widget _buildSlider() {
    return Container(
      margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      alignment: Alignment.bottomCenter,
      child: CarouselSlider(
        options: CarouselOptions(
            height: 100.0,
            initialPage: 0,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _bloc.moveCamera(widget.shops.elementAt(index).latLng);
            }),
        items: widget.shops.map((e) => _buildSliderIterm(e)).toList(),
      ),
    );
  }

  Widget _buildSliderIterm(Shop shop) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Icon(Icons.restaurant),
        ),
        title: Text(shop.shopName),
        subtitle: Text(
          shop.shopStatus,
          style: const TextStyle(color: Colors.green),
        ),
        trailing: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade700, width: 0.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '${shop.distance} km',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Image.asset(
                AssetConstant.ic_arrow_up,
                height: 24.0,
                width: 24.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
