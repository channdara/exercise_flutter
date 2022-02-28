import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreenBloc {
  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  void dispose() {
    controller.dispose();
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) return;
    await Permission.location.request();
  }
}
