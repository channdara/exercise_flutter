import 'package:exercise_flutter/src/constants/asset_constant.dart';

class Recommend {
  final String title, icon, image;

  Recommend(this.image, this.icon, this.title);

  static final List<Recommend> tmpRecommend = [
    Recommend(
      AssetConstant.splash_background,
      AssetConstant.ic_star,
      'Most View',
    ),
    Recommend(
      AssetConstant.splash_background,
      AssetConstant.ic_coupon,
      'Most Used\nCoupon',
    ),
    Recommend(
      AssetConstant.splash_background,
      AssetConstant.ic_review,
      'Top Review',
    ),
  ];
}
