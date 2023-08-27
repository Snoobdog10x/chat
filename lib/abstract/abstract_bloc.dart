import 'package:chat/abstract/appstore.dart';
import 'package:flutter/widgets.dart';

import 'abstract_state.dart';

abstract class AbstractBloc<T extends AbstractState> extends ChangeNotifier {
  late T state;
  AppStore get appStore => AppStore.getAppStore();
  void notifyDataChanged() {
    notifyListeners();
  }
}
