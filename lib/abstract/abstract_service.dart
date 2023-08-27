import 'appstore.dart';

abstract class AbstractService {
  AppStore get appStore => AppStore.getAppStore();
  bool hasBoot = false;

  Future<void> boot();
  void dispose();
}
