import 'appstore.dart';

abstract class AbstractService {
  final String GUEST_ID = "guest_id";
  AppStore get appStore => AppStore.getAppStore();
  bool hasBoot = false;

  Future<void> boot();
  void dispose();
}
