import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/screen/add_room/add_room.dart';
import 'package:chat/screen/chat_room/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../abstract/abstract_state.dart';
import 'home_chat_bloc.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({super.key});

  @override
  AbstractState<HomeChat> createState() => HomeChatState();
}

class HomeChatState extends AbstractState<HomeChat> {
  @override
  HomeChatBloc bloc = HomeChatBloc();

  @override
  void onCreate() {}

  @override
  Widget build(BuildContext context) {
    return buildScreen(
      appBarTitle: "Chat",
      body: buildRooms(),
      actions: [
        IconButton(
          onPressed: () {
            pushToScreen(AddRoom());
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget buildRooms() {
    return StreamBuilder(
      stream: appStore.chatService.rooms(),
      builder:
          (BuildContext context, AsyncSnapshot<List<types.Room>> snapshot) {
        if (!snapshot.hasData) return Container();
        var rooms = snapshot.data!;
        return ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            var room = rooms[index];
            return buildRoom(room);
          },
        );
      },
    );
  }

  Widget buildRoom(types.Room room) {
    var otherUser = room.users.firstWhere(
      (element) => element.id != bloc.currentUser.id,
    );
    return ListTile(
      onTap: () {
        pushToScreen(
          ChatRoom(
            room: room,
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(otherUser.imageUrl!),
      ),
      title: Text(otherUser.lastName! + otherUser.firstName!),
    );
  }

  @override
  void onPop() {
    notifyDataChanged();
    super.onPop();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }
}
