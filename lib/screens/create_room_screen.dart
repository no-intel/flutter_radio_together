import 'package:flutter/material.dart';
import 'package:radio_together/model/my_position.dart';

class CreateRoomScreen extends StatelessWidget {
  final MyPosition myPosition;

  const CreateRoomScreen({super.key, required this.myPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('방 만들기')),
      body: Center(),
    );
  }
}
