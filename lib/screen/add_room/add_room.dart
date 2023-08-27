import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/abstract/abstract_state.dart';
import 'package:chat/screen/add_room/add_room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => AddRoomState();
}

class AddRoomState extends AbstractState<AddRoom> {
  @override
  final AddRoomBloc bloc = AddRoomBloc();
  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }
  @override
  Widget build(BuildContext context) {
    return buildScreen(
      appBarTitle: "Create New Chat",
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: appStore.chatService.users(),
      builder:
          (BuildContext context, AsyncSnapshot<List<types.User>> snapshot) {
        if (!snapshot.hasData) return Container();
        var users = snapshot.data!;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            return buildUser(user);
          },
        );
      },
    );
  }

  Widget buildUser(types.User user) {
    return ListTile(
      onTap: () async {
        startLoading();
        await appStore.chatService.createRoom(user);
        stopLoading();
        popScreen();
      },
      leading: CircleAvatar(backgroundImage: NetworkImage(user.imageUrl!)),
      title: Text(user.lastName! + user.firstName!),
    );
  }
}
