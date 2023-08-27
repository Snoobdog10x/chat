import 'package:chat/abstract/abstract_event.dart';
import 'package:chat/abstract/abstract_exception.dart';
import 'package:chat/abstract/appstore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../abstract/abstract_repository.dart';

class UserRetrieveInputEvent extends InputEvent {
  String userId;
  UserRetrieveInputEvent(this.userId);
}

class UserRetrieveOutputEvent extends OutputEvent {
  types.User? user;
}

abstract mixin class UserRetrieve {
  AppStore get appStore;

  void requestUserRetrieve(UserRetrieveInputEvent inputEvent) async {
    UserRetrieveOutputEvent outputEvent = UserRetrieveOutputEvent();
    try {
      var userId = inputEvent.userId;

      var doc = await appStore.fireStoreService.db
          .collection(appStore.chatService.config.usersCollectionName)
          .doc(userId)
          .get();

      var data = doc.data();
      if (data == null) {
        throw NotFoundException('user');
      }
      
      data['createdAt'] = data['createdAt']!.millisecondsSinceEpoch;
      data['id'] = doc.id;
      data['lastSeen'] = data['lastSeen']!.millisecondsSinceEpoch;
      data['updatedAt'] = data['updatedAt']!.millisecondsSinceEpoch;

      outputEvent.user = types.User.fromJson(data);
      responseUserRetrieve(outputEvent);
    } on AbstractException catch (e) {
      outputEvent.exception = e;
      responseUserRetrieve(outputEvent);
    } catch (e) {
      outputEvent.exception = UnCatchException(e.toString());
      responseUserRetrieve(outputEvent);
    }
  }

  void responseUserRetrieve(UserRetrieveOutputEvent outputEvent);
}
