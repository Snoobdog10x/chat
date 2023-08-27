import 'package:chat/abstract/appstore.dart';

import 'abstract_event.dart';

mixin class AbstractRepository<I extends AbstractEvent,
    O extends AbstractEvent> {
  AppStore appStore = AppStore.getAppStore();

  void request(I inputEvent) {}
  void response(O outputEvent) {}
}
