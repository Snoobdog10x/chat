import 'package:chat/abstract/abstract_bloc.dart';
import 'package:flutter/material.dart';

import 'appstore.dart';

abstract class AbstractState<T extends StatefulWidget> extends State<T> {
  AbstractBloc get bloc;
  AppStore get appStore => bloc.appStore;
  bool isLoading = false;
  double get screenWidth => MediaQuery.sizeOf(context).width;
  double get screenHeight => MediaQuery.sizeOf(context).height;
  void onCreate();

  @override
  void initState() {
    onCreate();
    bloc.state = this;
    super.initState();
  }

  void startLoading() {
    if (isLoading) return;

    isLoading = true;
    notifyDataChanged();
  }

  void stopLoading() {
    if (!isLoading) return;

    isLoading = false;
    notifyDataChanged();
  }

  Widget buildScreen({
    Widget? body,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
    String appBarTitle = "",
    bool hasAppBar = true,
  }) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, widget) => Stack(
        children: [
          Scaffold(
            appBar: hasAppBar
                ? AppBar(
                    title: Text(appBarTitle),
                  )
                : null,
            body: Container(
              margin: margin,
              child: body,
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.15),
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void notifyDataChanged() {
    bloc.notifyDataChanged();
  }

  void pushToScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((value) {
      onPop();
    });
    onPush();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void onPop() {}
  void onPush() {}
}
