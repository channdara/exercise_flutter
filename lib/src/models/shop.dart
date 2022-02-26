import 'package:exercise_flutter/src/constants/asset_constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop {
  final String image, shopName, ratingAndReview, location, shopStatus;
  final double rating, distance;
  final int shopType, view;
  final LatLng latLng;

  Shop({
    required this.shopName,
    required this.shopType,
    required this.distance,
    required this.view,
    this.latLng = const LatLng(0.0, 0.0),
    this.image = AssetConstant.splash_background,
    this.ratingAndReview = '',
    this.location = 'Kandal',
    this.shopStatus = 'Open Now',
    this.rating = 0.0,
  });

  String get getShopType {
    switch (shopType) {
      case 1:
        return 'Coffee · Ice-Cream';
      case 2:
        return 'Pub · Bar';
      default:
        return '';
    }
  }

  String get getRatingAndReview =>
      ratingAndReview.isEmpty ? 'No Rating | No Review' : ratingAndReview;

  static final List<Shop> tmpShops = [
    Shop(
      shopName: 'Piseth Coffee Shop',
      shopType: 1,
      distance: 0.2,
      view: 16,
      latLng: const LatLng(11.4680461, 104.8945179),
    ),
    Shop(
      shopName: 'Nice Coffee',
      shopType: 1,
      distance: 0.7,
      view: 9,
      latLng: const LatLng(11.4700865, 104.9600957),
    ),
    Shop(
      shopName: 'Conexion Coffee & Pub',
      shopType: 2,
      distance: 0.8,
      view: 21,
      latLng: const LatLng(11.4764915, 104.9493042),
    ),
    Shop(
      shopName: 'K&T COFFEE Mr. KHAN TEY',
      shopType: 1,
      distance: 0.9,
      view: 32,
      latLng: const LatLng(11.4765135, 104.9409964),
    ),
    Shop(
      shopName: 'My Heart Coffee & Pub',
      shopType: 2,
      distance: 0.9,
      view: 11,
      latLng: const LatLng(11.4779917, 104.9472387),
    ),
    Shop(
      shopName: 'Troll Coffee',
      shopType: 1,
      distance: 0.9,
      view: 25,
      latLng: const LatLng(11.4643801, 104.953636),
    ),
  ];
}
