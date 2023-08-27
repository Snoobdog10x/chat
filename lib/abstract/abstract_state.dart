import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/screen/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appstore.dart';

abstract class AbstractState<T extends StatefulWidget> extends State<T> {
  AbstractBloc get bloc;
  AppStore get appStore => bloc.appStore;
  bool isLoading = false;
  bool isLogged = false;
  bool get secure => true;
  double get screenWidth => MediaQuery.sizeOf(context).width;
  double get screenHeight => MediaQuery.sizeOf(context).height;
  void onCreate();
  void onReady();
  @override
  void initState() {
    bloc.state = this;
    isLogged = appStore.userService.isLogged();
    onCreate();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (secure && !isLogged) {
        pushToScreen(Login(), isReplace: true);
        return;
      }

      onReady();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    List<Widget>? actions,
  }) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, widget) => Stack(
        children: [
          Scaffold(
            appBar: hasAppBar
                ? AppBar(
                    title: Text(appBarTitle),
                    actions: actions,
                  )
                : null,
            body: Container(
              margin: margin,
              child: body,
            ),
            resizeToAvoidBottomInset: true,
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

  void showAlertDialog({
    String? title,
    String? content,
    TextEditingController? controller,
    String confirmTitle = "OK",
    String cancelTitle = "NO",
    Function? confirm,
    Function? cancel,
    bool isLockOutsideTap = false,
  }) {
    stopLoading();
    List<CupertinoDialogAction> actions = [];
    if (cancel != null) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            cancel();
          },
          child: Text(cancelTitle),
        ),
      );
    }

    if (confirm != null) {
      actions.add(
        CupertinoDialogAction(
          onPressed: () {
            confirm();
          },
          child: Text(confirmTitle),
        ),
      );
    }
    Widget dialogContent = Text(content ?? "");
    if (controller != null) {
      dialogContent = Column(
        children: [
          Text(content ?? ""),
          CupertinoTextField(
            controller: controller,
          )
        ],
      );
    }
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: dialogContent,
        actions: actions,
      ),
    ).then((value) {
      onPop();
    });
  }

  void notifyDataChanged() {
    bloc.notifyDataChanged();
  }

  void pushToScreen(Widget screen, {bool isReplace = false}) {
    if (isReplace) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screen), (route) => false);
      return;
    }
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
