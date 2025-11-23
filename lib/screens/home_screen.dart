import 'package:flutter/material.dart';
import 'package:radio_together/widgets/home/background_widget.dart';
import 'package:radio_together/widgets/home/login_widget.dart';
import 'package:radio_together/widgets/home/title_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(136, 157, 159, 1),
      body: Stack(
        children: [
          BackgroundWidget(),
          Column(children: [TitleWidget(), LoginWidget()]),
        ],
      ),
    );
  }
}
