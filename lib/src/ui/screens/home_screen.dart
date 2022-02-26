import 'package:exercise_flutter/src/constants/asset_constant.dart';
import 'package:exercise_flutter/src/models/option.dart';
import 'package:exercise_flutter/src/models/recommend.dart';
import 'package:exercise_flutter/src/ui/screens/search_screen.dart';
import 'package:exercise_flutter/src/ui/widgets/app_icon_with_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final baseHeight = (MediaQuery.of(context).size.height - 56.0) / 3;
    return Column(
      children: [
        SizedBox(height: baseHeight + 56.0, child: _buildAppBar(baseHeight)),
        SizedBox(height: baseHeight - 28.0, child: _buildRecommendSection()),
        SizedBox(height: baseHeight - 28.0, child: _buildCouponSection()),
      ],
    );
  }

  Widget _buildAppBar(double baseHeight) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Image.asset(
                AssetConstant.splash_background,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Align(
                alignment: Alignment.center,
                child: AppIconWithText(iconSize: 45.0, textSize: 24.0),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    pushNewScreen(context, screen: const SearchScreen());
                  },
                  child: Container(
                    height: 32.0,
                    padding: const EdgeInsets.only(left: 8.0),
                    margin: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.red),
                        SizedBox(width: 4.0),
                        Text(
                          'Search restaurants',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildChoiceSelection(),
      ],
    );
  }

  Widget _buildChoiceSelection() {
    final width = MediaQuery.of(context).size.width / Option.tmpOptions.length;
    return Card(
      margin: const EdgeInsets.only(),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Row(
        children: List.generate(Option.tmpOptions.length, (index) {
          final item = Option.tmpOptions.elementAt(index);
          return Container(
            width: width,
            height: 55.0,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(width: 0.0, color: Colors.grey)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.red, size: 16.0),
                const SizedBox(height: 4.0),
                Text(item.title, style: const TextStyle(fontSize: 10.0)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRecommendSection() {
    final width = MediaQuery.of(context).size.width / 3.27;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('Recommended'),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: Recommend.tmpRecommend.length,
            itemBuilder: (context, index) {
              final item = Recommend.tmpRecommend.elementAt(index);
              return Card(
                margin: const EdgeInsets.only(right: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    Image.asset(
                      item.image,
                      width: width,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: width,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            item.icon,
                            height: 32.0,
                            width: 32.0,
                            color: Colors.white,
                          ),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCouponSection() {
    final width = MediaQuery.of(context).size.width / 1.2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('Coupon'),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(right: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  AssetConstant.splash_background,
                  width: width,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
